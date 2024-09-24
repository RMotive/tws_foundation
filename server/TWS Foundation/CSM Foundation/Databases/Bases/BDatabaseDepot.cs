using System.Linq.Expressions;
using System.Reflection;

using CSM_Foundation.Core.Utils;
using CSM_Foundation.Databases.Enumerators;
using CSM_Foundation.Databases.Interfaces;
using CSM_Foundation.Databases.Models;
using CSM_Foundation.Databases.Models.Options;
using CSM_Foundation.Databases.Models.Out;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;

namespace CSM_Foundation.Databases.Bases;
/// <summary>
///     Defines base behaviors for a <see cref="IMigrationDepot{TMigrationSet}"/>
///     implementation describing <see cref="BDatabaseDepot{TMigrationDatabases, TMigrationSet}"/>
///     shared behaviors.
///     
///     A <see cref="BDatabaseDepot{TMigrationDatabases, TMigrationSet}"/> provides methods to 
///     serve dataDatabases saved transactions for <see cref="TMigrationSet"/>.
/// </summary>
/// <typeparam name="TMigrationDatabases">
///     What Database implementation belongs this depot.
/// </typeparam>
/// <typeparam name="TMigrationSet">
///     Migration mirror concept that this depot handles.
/// </typeparam>
public abstract class BDatabaseDepot<TMigrationDatabases, TMigrationSet>
    : IMigrationDepot<TMigrationSet>
    where TMigrationDatabases : BDatabaseSQLS<TMigrationDatabases>
    where TMigrationSet : class, IDatabasesSet {

    protected readonly IMigrationDisposer? Disposer;
    /// <summary>
    ///     Name to handle direct transactions (not-saved)
    /// </summary>
    protected readonly TMigrationDatabases Database;
    /// <summary>
    ///     DBSet handler into <see cref="Database"/> to handle fastlike transactions related to the <see cref="TMigrationSet"/> 
    /// </summary>
    protected readonly DbSet<TMigrationSet> Set;
    /// <summary>
    ///     Generates a new instance of a <see cref="BDatabaseDepot{TMigrationDatabases, TMigrationSet}"/> base.
    /// </summary>
    /// <param name="Databases">
    ///     The <typeparamref name="TMigrationDatabases"/> that stores and handles the transactions for this <see cref="TMigrationSet"/> concept.
    /// </param>
    public BDatabaseDepot(TMigrationDatabases Databases, IMigrationDisposer? Disposer) {
        this.Database = Databases;
        this.Disposer = Disposer;
        Set = Databases.Set<TMigrationSet>();
    }

    #region View 

    public Task<SetViewOut<TMigrationSet>> View(SetViewOptions Options, Func<IQueryable<TMigrationSet>, IQueryable<TMigrationSet>>? include = null) {
        int range = Options.Range;
        int page = Options.Page;
        int amount = Set.Count();
        (int pages, int left) = Math.DivRem(amount, range);
        if (left > 0) {
            pages++;
        }

        int start = (page - 1) * range;
        int records = page == pages ? left : range;
        IQueryable<TMigrationSet> query = Set
            .Skip(start)
            .Take(records);

        if (include != null) {
            query = include(query);
        }

        int orderActions = Options.Orderings.Length;
        if (orderActions > 0) {
            Type setType = typeof(TMigrationSet);
            IOrderedQueryable<TMigrationSet> orderingQuery = default!;

            for (int i = 0; i < orderActions; i++) {
                ParameterExpression parameterExpression = Expression.Parameter(setType, $"X{i}");
                SetViewOrderOptions ordering = Options.Orderings[i];

                PropertyInfo property = setType.GetProperty(ordering.Property)
                    ?? throw new Exception($"Unexisted property ({ordering.Property}) on ({setType})");
                MemberExpression memberExpression = Expression.MakeMemberAccess(parameterExpression, property);
                UnaryExpression translationExpression = Expression.Convert(memberExpression, typeof(object));
                Expression<Func<TMigrationSet, object>> orderingExpression = Expression.Lambda<Func<TMigrationSet, object>>(translationExpression, parameterExpression);
                if (i == 0) {
                    orderingQuery = ordering.Behavior switch {
                        MIgrationViewOrderBehaviors.DownUp => query.OrderBy(orderingExpression),
                        MIgrationViewOrderBehaviors.UpDown => query.OrderByDescending(orderingExpression),
                        _ => query.OrderBy(orderingExpression),
                    };
                    continue;
                }

                orderingQuery = ordering.Behavior switch {
                    MIgrationViewOrderBehaviors.DownUp => orderingQuery.ThenBy(orderingExpression),
                    MIgrationViewOrderBehaviors.UpDown => orderingQuery.ThenByDescending(orderingExpression),
                    _ => orderingQuery.ThenBy(orderingExpression),
                };
            }
            query = orderingQuery;
        }

        TMigrationSet[] sets = [.. query];

        return Task.FromResult(new SetViewOut<TMigrationSet>() {
            Amount = amount,
            Pages = pages,
            Page = page,
            Sets = sets,
        });
    }

    #endregion


    #region Create

    /// <summary>
    ///     Creates a new record into the dataDatabases.
    /// </summary>
    /// <param name="Set">
    ///     <see cref="TMigrationSet"/> to store.
    /// </param>
    /// <returns> 
    ///     The stored object. (Object Id is always auto-generated)
    /// </returns>
    public async Task<TMigrationSet> Create(TMigrationSet Set) {
        Set.EvaluateWrite();

        _ = await this.Set.AddAsync(Set);
        _ = await Database.SaveChangesAsync();
        Database.ChangeTracker.Clear();

        Disposer?.Push(Database, [Set]);
        return Set;
    }
    /// <summary>
    ///     Creates a collection of records into the dataDatabases. 
    ///     <br>
    ///         Depending on <paramref name="Sync"/> the transaction performs different,
    ///         the operation iterates the desire collection to store and collects all the 
    ///         failures gathered during the operation.
    ///     </br>
    /// </summary>
    /// <param name="Sets">
    ///     The collection to store.
    /// </param>
    /// <param name="Sync">
    ///     Determines if the transaction should be broke at the first failure catched. This means that
    ///     the previous successfully stored objects will be kept as stored but the next ones objects desired
    ///     to be stored won't continue, the operation will throw new exception.
    /// </param>
    /// <returns>
    ///     A <see cref="DatabasesTransactionOut{TSet}"/> that stores a collection of failures, and successes caught.
    /// </returns>
    public async Task<DatabasesTransactionOut<TMigrationSet>> Create(TMigrationSet[] Sets, bool Sync = false) {
        TMigrationSet[] saved = [];
        SourceTransactionFailure<TMigrationSet>[] fails = [];

        foreach (TMigrationSet record in Sets) {
            try {
                //AttachDate(record);
                record.EvaluateWrite();
                Database.ChangeTracker.Clear();
                Set.Attach(record);
                await Database.SaveChangesAsync();
                saved = [.. saved, record];
            } catch (Exception excep) {
                if (Sync) {
                    throw;
                }

                SourceTransactionFailure<TMigrationSet> fail = new(record, excep);
                fails = [.. fails, fail];
            }
        }

        Disposer?.Push(Database, Sets);
        return new(saved, fails);
    }

    #endregion

    #region Read
    public async Task<DatabasesTransactionOut<TMigrationSet>> Read(Expression<Func<TMigrationSet, bool>> Predicate, MigrationReadBehavior Behavior, Func<IQueryable<TMigrationSet>, IQueryable<TMigrationSet>>? Include = null) {
        IQueryable<TMigrationSet> query = Set.Where(Predicate);

        if (Include != null) {
            query = Include(query);
        }

        if (!query.Any()) {
            return new DatabasesTransactionOut<TMigrationSet>([], []);
        }

        TMigrationSet[] items = Behavior switch {
            MigrationReadBehavior.First => [await query.FirstAsync()],
            MigrationReadBehavior.Last => [await query.LastAsync()],
            MigrationReadBehavior.All => await query.ToArrayAsync(),
            _ => throw new NotImplementedException()
        };


        TMigrationSet[] successes = [];
        SourceTransactionFailure<TMigrationSet>[] failures = [];
        foreach (TMigrationSet item in items) {
            try {
                item.EvaluateRead();

                successes = [.. successes, item];
            } catch (Exception excep) {
                SourceTransactionFailure<TMigrationSet> failure = new(item, excep);
                failures = [.. failures, failure];
            }
        }

        return new(successes, failures);
    }
    #endregion

    #region Update 

    /// <summary>
    /// Perform the navigation changes in a Tmigrationset
    /// </summary>
    //Database.Entry(previousList[i]).CurrentValues.SetValues(newitem);

    void UpdateHelper(IDatabasesSet current, IDatabasesSet Record) {
        EntityEntry previousEntry = Database.Entry(current);
        if (previousEntry.State == EntityState.Unchanged) {
            //AttachDate(Record, true);
            // Update the non-navigation properties.
            previousEntry.CurrentValues.SetValues(Record);
            foreach (NavigationEntry navigation in previousEntry.Navigations) {
                object? newNavigationValue = Database.Entry(Record).Navigation(navigation.Metadata.Name).CurrentValue;
                // Validate if navigation is a collection.
                if (navigation.CurrentValue is IEnumerable<object> previousCollection && newNavigationValue is IEnumerable<object> newCollection) {
                    List<object> previousList = previousCollection.ToList();
                    List<object> newList = newCollection.ToList();
                    // Perform a search for new items to add in the collection.
                    // NOTE: the followings iterations must be performed in diferent code segments to avoid index length conflicts.
                    for (int i = 0; i < newList.Count; i++) {
                        IDatabasesSet? newItemSet = (IDatabasesSet)newList[i];
                        if (newItemSet != null && newItemSet.Id <= 0) {
                            //AttachDate(newList[i]);
                            EntityEntry newNavigationEntry = Database.Entry(newList[i]);
                            newNavigationEntry.State = EntityState.Added;
                        }
                    }
                    for (int i = 0; i < previousList.Count; i++) {
                        // Find items to modify.
                        // For each new item stored in record collection, will search for an ID match and update the record.
                        foreach (object newitem in newList) {
                            if (previousList[i] is IDatabasesSet previousItem && newitem is IDatabasesSet newItemSet && previousItem.Id == newItemSet.Id)
                                UpdateHelper(previousItem, newItemSet);
                        }
                    }
                } else if (navigation.CurrentValue == null && newNavigationValue != null) {
                    // Create a new navigation entity.
                    // Also update the attached navigators.
                    //AttachDate(newNavigationValue);
                    EntityEntry newNavigationEntry = Database.Entry(newNavigationValue);
                    newNavigationEntry.State = EntityState.Added;
                    navigation.CurrentValue = newNavigationValue;
                } else if (navigation.CurrentValue != null && newNavigationValue != null) {
                    // Update the existing navigation entity


                    if (navigation.CurrentValue is IDatabasesSet currentItemSet && newNavigationValue is IDatabasesSet newItemSet) UpdateHelper(currentItemSet, newItemSet);
                }

            }
        }

    }
   
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Set"></param>
    /// <returns></returns>
    /// <exception cref="NotImplementedException"></exception>
    public async Task<RecordUpdateOut<TMigrationSet>> Update(TMigrationSet Record, Func<IQueryable<TMigrationSet>, IQueryable<TMigrationSet>>? Include = null) {
        IQueryable<TMigrationSet> query = Set;
        TMigrationSet? old = null;
        TMigrationSet? current;
        if (Include != null) {
            query = Include(query);
        }
        current = await query
            .Where(i => i.Id == Record.Id)
            .FirstOrDefaultAsync();

        if (current != null) {
            Set.Attach(current);
            old = current.DeepCopy();
            UpdateHelper(current, Record);
        } else {
            //Generate a new insert if the given record data not exist.
            //AttachDate(Record);
            Set.Update(Record);
        }
        await Database.SaveChangesAsync();

        Disposer?.Push(Database, Record);
        return new RecordUpdateOut<TMigrationSet> {
            Previous = old,
            Updated = current ?? Record,
        };
    }

    #endregion

    #region Delete

    public Task<DatabasesTransactionOut<TMigrationSet>> Delete(TMigrationSet[] Sets) {

        TMigrationSet[] safe = [];
        SourceTransactionFailure<TMigrationSet>[] fails = [];

        foreach (TMigrationSet set in Sets) {
            try {
                set.EvaluateWrite();
                safe = [.. safe, set];
            } catch (Exception excep) {
                SourceTransactionFailure<TMigrationSet> fail = new(set, excep);
                fails = [.. fails, fail];
            }
        }

        Set.RemoveRange(safe);
        return Task.FromResult<DatabasesTransactionOut<TMigrationSet>>(new(safe, []));
    }

    public async Task<TMigrationSet> Delete(TMigrationSet Set) {
        Set.EvaluateWrite();
        _ = this.Set.Remove(Set);
        _ = await Database.SaveChangesAsync();
        Database.ChangeTracker.Clear();
        return Set;
    }

    public async Task<TMigrationSet> Delete(int Id) {
        TMigrationSet record = await Set
            .AsNoTracking()
            .Where(r => r.Id == Id)
            .FirstOrDefaultAsync()
            ?? throw new Exception("Trying to remove an unexist record");

        Set.Remove(record);
        await Database.SaveChangesAsync();

        return record;
    }

    #endregion
}