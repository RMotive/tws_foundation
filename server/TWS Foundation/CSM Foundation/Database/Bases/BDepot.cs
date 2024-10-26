using System.Linq.Expressions;
using System.Reflection;

using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Enumerators;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Models;
using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;

namespace CSM_Foundation.Database.Bases;
/// <summary>
///     Defines base behaviors for a <see cref="IDepot{TMigrationSet}"/>
///     implementation describing <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     shared behaviors.
///     
///     A <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/> provides methods to 
///     serve dataDatabases saved transactions for <see cref="TSet"/>.
/// </summary>
/// <typeparam name="TDatabase">
///     What Database implementation belongs this depot.
/// </typeparam>
/// <typeparam name="TSet">
///     Migration mirror concept that this depot handles.
/// </typeparam>
public abstract class BDepot<TDatabase, TSet>
    : IDepot<TSet>
    where TDatabase : BDatabaseSQLS<TDatabase>
    where TSet : class, ISet {

    /// <summary>
    /// 
    /// </summary>
    protected readonly IDisposer? Disposer;

    /// <summary>
    ///     Name to handle direct transactions (not-saved)
    /// </summary>
    protected readonly TDatabase Database;

    /// <summary>
    ///     DBSet handler into <see cref="Database"/> to handle fastlike transactions related to the <see cref="TSet"/> 
    /// </summary>
    protected readonly DbSet<TSet> Set;

    /// <summary>
    ///     Generates a new instance of a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/> base.
    /// </summary>
    /// <param name="Database">
    ///     The <typeparamref name="TDatabase"/> that stores and handles the transactions for this <see cref="TSet"/> concept.
    /// </param>
    public BDepot(TDatabase Database, IDisposer? Disposer) {
        this.Database = Database;
        this.Disposer = Disposer;
        Set = Database.Set<TSet>();
    }

    protected IQueryable<TSet> Filtering(SetViewOptions<TSet> Options, IQueryable<TSet> Source) {
        ISetViewFilterNode<TSet>[] filters = Options.Filters;
        if (filters.Length > 0) {
            filters = [.. filters.OrderBy(x => x.Order)];

            foreach (ISetViewFilterNode<TSet> filter in filters) {
                Expression<Func<TSet, bool>> queryExpression = filter.Compose();
                string lambdaValue = queryExpression.ToString();

                Source = Source.Where(queryExpression);
            }
        }

        return Source;
    }

    public (IQueryable<TSet>, int Amount, int Pages, int Page) Paging(SetViewOptions<TSet> Options, IQueryable<TSet> Source) {

        int range = Options.Range;
        int page = Options.Page;
        int amount = Set.Count();
        (int pages, int left) = Math.DivRem(amount, range);
        if (left > 0) {
            pages++;
        }

        int start = (page - 1) * range;
        int records = page == pages ? left : range;

        Source = Source
            .Skip(start)
            .Take(records);

        return (Source, amount, pages, page);
    }

    public IQueryable<TSet> Ordering(SetViewOptions<TSet> Options, IQueryable<TSet> Source) {
        int orderActions = Options.Orderings.Length;
        if (orderActions <= 0) {
            return Source;
        }

        Type setType = typeof(TSet);
        IOrderedQueryable<TSet> orderingQuery = default!;

        for (int i = 0; i < orderActions; i++) {
            ParameterExpression parameterExpression = Expression.Parameter(setType, $"X{i}");
            SetViewOrderOptions ordering = Options.Orderings[i];

            PropertyInfo property = setType.GetProperty(ordering.Property)
                ?? throw new Exception($"Unexisted property ({ordering.Property}) on ({setType})");
            MemberExpression memberExpression = Expression.MakeMemberAccess(parameterExpression, property);
            UnaryExpression translationExpression = Expression.Convert(memberExpression, typeof(object));
            Expression<Func<TSet, object>> orderingExpression = Expression.Lambda<Func<TSet, object>>(translationExpression, parameterExpression);
            if (i == 0) {
                orderingQuery = ordering.Behavior switch {
                    SetViewOrders.Ascending => Source.OrderBy(orderingExpression),
                    SetViewOrders.Descending => Source.OrderByDescending(orderingExpression),
                    _ => Source.OrderBy(orderingExpression),
                };
                continue;
            }

            orderingQuery = ordering.Behavior switch {
                SetViewOrders.Ascending => orderingQuery.ThenBy(orderingExpression),
                SetViewOrders.Descending => orderingQuery.ThenByDescending(orderingExpression),
                _ => orderingQuery.ThenBy(orderingExpression),
            };
        }
        return orderingQuery;
    }

    public Task<SetViewOut<TSet>> Processing(SetViewOptions<TSet> Options, IQueryable<TSet> Source, Func<IQueryable<TSet>, IQueryable<TSet>>? inclusions = null) {
        IQueryable<TSet> query = Source;

        query = Filtering(Options, query);

        (IQueryable<TSet> source, int amount, int pages, int page) = Paging(Options, query);

        query = source;

        query = Ordering(Options, query);

        query = inclusions?.Invoke(query) ?? query;

        TSet[] sets = [.. query];

        return Task.FromResult(
            new SetViewOut<TSet>() {
                Amount = amount,
                Pages = pages,
                Page = page,
                Sets = sets,
            }
        );
    }

    #region View 

    public Task<SetViewOut<TSet>> View(SetViewOptions<TSet> Options, Func<IQueryable<TSet>, IQueryable<TSet>>? include = null) {
        return Processing(Options, Set, include);
    }

    #endregion


    #region Create

    /// <summary>
    ///     Creates a new record into the dataDatabases.
    /// </summary>
    /// <param name="Set">
    ///     <see cref="TSet"/> to store.
    /// </param>
    /// <returns> 
    ///     The stored object. (Object Id is always auto-generated)
    /// </returns>
    public async Task<TSet> Create(TSet Set) {
        Set.Timestamp = DateTime.UtcNow;
        Set.EvaluateWrite();

        await this.Set.AddAsync(Set);
        await Database.SaveChangesAsync();
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
    ///     A <see cref="SetBatchOut{TSet}"/> that stores a collection of failures, and successes caught.
    /// </returns>
    public async Task<SetBatchOut<TSet>> Create(TSet[] Sets, bool Sync = false) {
        TSet[] saved = [];
        SetOperationFailure<TSet>[] fails = [];

        foreach (TSet record in Sets) {
            try {
                record.Timestamp = DateTime.UtcNow;
                record.EvaluateWrite();
                Database.ChangeTracker.Clear();
                Set.Attach(record);
                await Database.SaveChangesAsync();
                saved = [.. saved, record];
            } catch (Exception excep) {
                if (Sync) {
                    throw;
                }

                SetOperationFailure<TSet> fail = new(record, excep);
                fails = [.. fails, fail];
            }
        }

        Disposer?.Push(Database, Sets);
        return new(saved, fails);
    }

    #endregion

    #region Read
    public async Task<SetBatchOut<TSet>> Read(Expression<Func<TSet, bool>> Predicate, SetReadBehaviors Behavior, Func<IQueryable<TSet>, IQueryable<TSet>>? Include = null) {
        IQueryable<TSet> query = Set.Where(Predicate);

        if (Include != null) {
            query = Include(query);
        }

        if (!query.Any()) {
            return new SetBatchOut<TSet>([], []);
        }

        TSet[] items = Behavior switch {
            SetReadBehaviors.First => [await query.FirstAsync()],
            SetReadBehaviors.Last => [await query.LastAsync()],
            SetReadBehaviors.All => await query.ToArrayAsync(),
            _ => throw new NotImplementedException()
        };


        TSet[] successes = [];
        SetOperationFailure<TSet>[] failures = [];
        foreach (TSet item in items) {
            try {
                item.EvaluateRead();

                successes = [.. successes, item];
            } catch (Exception excep) {
                SetOperationFailure<TSet> failure = new(item, excep);
                failures = [.. failures, failure];
            }
        }

        return new(successes, failures);
    }
    #endregion

    #region Update 

    /// <summary>
    /// 
    /// </summary>
    /// <param name="current"> Lastest data set stored in db sorce. </param>
    /// <param name="Record"> Modified set given in update service params. This modifications must be applied to the [current] set in db source. </param>
    private void UpdateHelper(ISet current, ISet Record) {
        EntityEntry previousEntry = Database.Entry(current);
        if (previousEntry.State == EntityState.Unchanged) {
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
                        ISet? newItemSet = (ISet)newList[i];
                        if (newItemSet != null && newItemSet.Id <= 0) {
                            // Getting the item type to add.
                            Type itemType = newItemSet.GetType();
                            // Getting the Add method from Icollection.
                            var addMethod = previousCollection.GetType().GetMethod("Add", [itemType]);
                            // Adding the new item to Icollection.
                            if (addMethod != null) addMethod.Invoke(previousCollection, [newItemSet]);

                        }
                    }
                    // Find items to modify.
                    for (int i = 0; i < previousList.Count; i++) {
                        // For each new item stored in record collection, will search for an ID match and update the record.
                        foreach (object newitem in newList) {
                            if (previousList[i] is ISet previousItem && newitem is ISet newItemSet && previousItem.Id == newItemSet.Id) {
                                UpdateHelper(previousItem, newItemSet);
                            }
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
                    if (navigation.CurrentValue is ISet currentItemSet && newNavigationValue is ISet newItemSet) {
                        UpdateHelper(currentItemSet, newItemSet);
                    }
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
    public async Task<RecordUpdateOut<TSet>> Update(TSet Record, Func<IQueryable<TSet>, IQueryable<TSet>>? Include = null) {
        IQueryable<TSet> query = Set;
        TSet? old = null;
        TSet? current;
        if (Include != null) {
            query = Include(query);
        }
        current = await query
            .Where(i => i.Id == Record.Id)
            .FirstOrDefaultAsync();

        if (current != null) {
            Set.Attach(current);
            old = current.DeepCopy();

            Record.Timestamp = old.Timestamp;
            UpdateHelper(current, Record);
            await Database.SaveChangesAsync();
        } else {
            Record.Timestamp = DateTime.Now;
            Set.Update(Record);
            await Database.SaveChangesAsync();

            current = await query
                .Where(i => i.Id == Record.Id)
                .FirstOrDefaultAsync();
        }

        Disposer?.Push(Database, Record);
        return new RecordUpdateOut<TSet> {
            Previous = old,
            Updated = current ?? Record,
        };
    }

    #endregion

    #region Delete

    public Task<SetBatchOut<TSet>> Delete(TSet[] Sets) {

        TSet[] safe = [];
        SetOperationFailure<TSet>[] fails = [];

        foreach (TSet set in Sets) {
            try {
                set.EvaluateWrite();
                safe = [.. safe, set];
            } catch (Exception excep) {
                SetOperationFailure<TSet> fail = new(set, excep);
                fails = [.. fails, fail];
            }
        }

        Set.RemoveRange(safe);
        return Task.FromResult<SetBatchOut<TSet>>(new(safe, []));
    }

    public async Task<TSet> Delete(TSet Set) {
        Set.EvaluateWrite();
        _ = this.Set.Remove(Set);
        _ = await Database.SaveChangesAsync();
        Database.ChangeTracker.Clear();
        return Set;
    }

    public async Task<TSet> Delete(int Id) {
        TSet record = await Set
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