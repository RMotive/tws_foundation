using System.Linq.Expressions;
using System.Reflection;

using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Entity.Filters;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;

namespace CSM_Foundation.Database.Entity;

/// <summary>
///     Defines base behaviors for a <see cref="IDepot{TMigrationSet}"/>
///     implementation describing <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     shared behaviors.
///     
///     A <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/> provides methods to 
///     serve dataDatabases attached transactions for <see cref="TEntity"/>.
/// </summary>
/// <typeparam name="TDatabase">
///     What Database implementation belongs this depot.
/// </typeparam>
/// <typeparam name="TEntity">
///     Migration mirror concept that this depot handles.
/// </typeparam>
public abstract class BDepot<TDatabase, TEntity>
    : IDepot<TEntity>
    where TDatabase : BDatabase_SQLServer<TDatabase>
    where TEntity : class, IEntity {

    /// <summary>
    /// 
    /// </summary>
    protected readonly IDisposer? Disposer;

    /// <summary>
    ///     Name to handle direct transactions (not-attached)
    /// </summary>
    protected readonly TDatabase Database;

    /// <summary>
    ///     DBSet handler into <see cref="Database"/> to handle fastlike transactions related to the <see cref="TEntity"/> 
    /// </summary>
    protected readonly DbSet<TEntity> Set;

    /// <summary>
    ///     Generates a new instance of a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/> base.
    /// </summary>
    /// <param name="Database">
    ///     The <typeparamref name="TDatabase"/> that stores and handles the transactions for this <see cref="TEntity"/> concept.
    /// </param>
    public BDepot(TDatabase Database, IDisposer? Disposer) {
        this.Database = Database;
        this.Disposer = Disposer;
        Set = Database.Set<TEntity>();
    }

    protected IQueryable<TEntity> Filtering(SetViewOptions<TEntity> Options, IQueryable<TEntity> Source) {
        ISetViewFilterNode<TEntity>[] filters = Options.Filters;
        if (filters.Length > 0) {
            filters = [.. filters.OrderBy(x => x.Order)];

            foreach (ISetViewFilterNode<TEntity> filter in filters) {
                Expression<Func<TEntity, bool>> queryExpression = filter.Compose();
                Source = Source.Where(queryExpression);
            }
        }

        return Source;
    }

    public (IQueryable<TEntity>, int Amount, int Pages, int Page) Paging(SetViewOptions<TEntity> Options, IQueryable<TEntity> Source) {

        int range = Options.Range;
        int page = Options.Page;
        if (Options.Export) {
            page = 1;
            range = Source.Count();
        }

        int amount = Source.Count();
        (int pages, int left) = Math.DivRem(amount, range);
        if (left > 0) {
            pages++;
        }

        int start = (page - 1) * range;

        int records = page == pages ? left == 0 ? range : left : range;
        Source = Source
            .Skip(start)
            .Take(records);

        return (Source, amount, pages, page);
    }

    public IQueryable<TEntity> Ordering(SetViewOptions<TEntity> Options, IQueryable<TEntity> Source) {
        int orderActions = Options.Orderings.Length;
        if (orderActions <= 0) {
            return Source;
        }

        Type setType = typeof(TEntity);
        IOrderedQueryable<TEntity> orderingQuery = default!;

        for (int i = 0; i < orderActions; i++) {
            ParameterExpression parameterExpression = Expression.Parameter(setType, $"X{i}");
            SetViewOrderOptions ordering = Options.Orderings[i];

            PropertyInfo property = setType.GetProperty(ordering.Property)
                ?? throw new Exception($"Unexisted property ({ordering.Property}) on ({setType})");
            MemberExpression memberExpression = Expression.MakeMemberAccess(parameterExpression, property);
            UnaryExpression translationExpression = Expression.Convert(memberExpression, typeof(object));
            Expression<Func<TEntity, object>> orderingExpression = Expression.Lambda<Func<TEntity, object>>(translationExpression, parameterExpression);
            if (i == 0) {
                orderingQuery = ordering.Order switch {
                    SetViewOrders.Ascending => Source.OrderBy(orderingExpression),
                    SetViewOrders.Descending => Source.OrderByDescending(orderingExpression),
                    _ => Source.OrderBy(orderingExpression),
                };
                continue;
            }

            orderingQuery = ordering.Order switch {
                SetViewOrders.Ascending => orderingQuery.ThenBy(orderingExpression),
                SetViewOrders.Descending => orderingQuery.ThenByDescending(orderingExpression),
                _ => orderingQuery.ThenBy(orderingExpression),
            };
        }
        return orderingQuery;
    }

    public Task<SetViewOut<TEntity>> Processing(SetViewOptions<TEntity> Options, AccumulateDelegate<TEntity>? Accumulate = null) {
        IQueryable<TEntity> query = Set.AsNoTracking();

        query = Ordering(Options, query);

        query = Filtering(Options, query);

        query = Accumulate?.Invoke(query) ?? query;

        (IQueryable<TEntity> source, int amount, int pages, int page) = Paging(Options, query);

        query = source;

        TEntity[] sets = [.. query];

        return Task.FromResult(
            new SetViewOut<TEntity>() {
                Count = amount,
                Pages = pages,
                Page = page,
                Records = sets,
            }
        );
    }


    #region View 

    public Task<SetViewOut<TEntity>> View(SetViewOptions<TEntity> Options, AccumulateDelegate<TEntity>? Accumulate = null) {
        return Processing(Options, Accumulate);
    }

    #endregion

    #region Create

    /// <summary>
    ///     Creates a new entity into the dataDatabases.
    /// </summary>
    /// <param name="entity">
    ///     <see cref="TEntity"/> to store.
    /// </param>
    /// <returns> 
    ///     The stored object. (Object Id is always auto-generated)
    /// </returns>
    public async Task<TEntity> Create(TEntity entity) {
        entity.Timestamp = DateTime.UtcNow;
        entity.EvaluateWrite();

        await this.Set.AddAsync(entity);

        Disposer?.Push(Database, entity);
        return entity;
    }

    /// <summary>
    ///     Creates a collection of records into the dataDatabases. 
    ///     <br>
    ///         Depending on <paramref name="sync"/> the transaction performs different,
    ///         the operation iterates the desire collection to store and collects all the 
    ///         failures gathered during the operation.
    ///     </br>
    /// </summary>
    /// <param name="entities">
    ///     The collection to store.
    /// </param>
    /// <param name="sync">
    ///     Determines if the transaction should be broken at the first failure catched. This means that
    ///     the previous successfully stored objects will be kept as stored but the next ones objects desired
    ///     to be stored won't continue, the operation will throw new exception.
    /// </param>
    /// <returns>
    ///     A <see cref="SetBatchOut{TSet}"/> that stores a collection of failures, and successes caught.
    /// </returns>
    public async Task<SetBatchOut<TEntity>> Create(TEntity[] entities, bool sync = false) {
        TEntity[] attached = [];
        SetOperationFailure<TEntity>[] failures = [];

        foreach (TEntity entity in entities) {
            try {
                TEntity attachedEntity = await Create(entity);
                attached = [.. attached, attachedEntity];
            } catch (Exception excep) {
                if (sync) {
                    throw;
                }

                SetOperationFailure<TEntity> fail = new(entity, excep);
                failures = [.. failures, fail];
            }
        }

        return new(attached, failures);
    }

    #endregion

    #region Read
    public async Task<SetBatchOut<TEntity>> Read(ReadBehaviors Behavior, Expression<Func<TEntity, bool>> Filter, AccumulateDelegate<TEntity>? Accumulate = null) {
        IQueryable<TEntity> query = Set.Where(Filter);

        if (Accumulate != null) {
            query = Accumulate(query);
        }

        if (!query.Any()) {
            return new SetBatchOut<TEntity>([], []);
        }

        TEntity[] items = Behavior switch {
            ReadBehaviors.First => [await query.FirstAsync()],
            ReadBehaviors.Last => [await query.LastAsync()],
            ReadBehaviors.All => await query.ToArrayAsync(),
            _ => throw new NotImplementedException()
        };


        TEntity[] successes = [];
        SetOperationFailure<TEntity>[] failures = [];
        foreach (TEntity item in items) {
            try {
                item.EvaluateRead();

                successes = [.. successes, item];
            } catch (Exception excep) {
                SetOperationFailure<TEntity> failure = new(item, excep);
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
    void UpdateHelper(IEntity current, IEntity Record) {
        EntityEntry previousEntry = Database.Entry(current);
        if (previousEntry.State == EntityState.Unchanged) {
            // Update the non-navigation properties.
            previousEntry.CurrentValues.SetValues(Record);
            foreach (NavigationEntry navigation in previousEntry.Navigations) {
                object? newNavigationValue = Database.Entry(Record).Navigation(navigation.Metadata.Name).CurrentValue;
                // Validate if navigation is a collection.
                if (navigation.CurrentValue is IEnumerable<object> previousCollection && newNavigationValue is IEnumerable<object> newCollection) {
                    List<object> previousList = [.. previousCollection];
                    List<object> newList = [.. newCollection];
                    // Perform a search for new items to add in the collection.
                    // NOTE: the followings iterations must be performed in diferent code segments to avoid index length conflicts.
                    for (int i = 0; i < newList.Count; i++) {
                        IEntity? newItemSet = (IEntity)newList[i];
                        if (newItemSet != null && newItemSet.Id <= 0) {
                            // Getting the item type to add.
                            Type itemType = newItemSet.GetType();
                            // Getting the Add method from Icollection.
                            var addMethod = previousCollection.GetType().GetMethod("Add", [itemType]);
                            // Adding the new item to Icollection.
                            _ = (addMethod?.Invoke(previousCollection, [newItemSet]));

                        }
                    }
                    // Find items to modify.
                    for (int i = 0; i < previousList.Count; i++) {
                        // For each new item stored in entity collection, will search for an ID match and update the entity.
                        foreach (object newitem in newList) {
                            if (previousList[i] is IEntity previousItem && newitem is IEntity newItemSet && previousItem.Id == newItemSet.Id) {
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
                    if (navigation.CurrentValue is IEntity currentItemSet && newNavigationValue is IEntity newItemSet) {
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
    public async Task<EntityUpdateOut<TEntity>> Update(TEntity Record, AccumulateDelegate<TEntity>? Accumulate = null) {
        IQueryable<TEntity> query = Set;
        TEntity? old = null;
        TEntity? current;
        Record.EvaluateWrite();
        if (Accumulate != null) {
            query = Accumulate(query);
        }
        current = await query
            .Where(i => i.Id == Record.Id)
            .FirstOrDefaultAsync();

        if (current != null) {
            _ = Set.Attach(current);
            old = current.DeepCopy();

            Record.Timestamp = old.Timestamp;
            UpdateHelper(current, Record);
            _ = await Database.SaveChangesAsync();
        } else {
            Record.Timestamp = DateTime.Now;
            _ = Set.Update(Record);
            _ = await Database.SaveChangesAsync();

            current = await query
                .Where(i => i.Id == Record.Id)
                .FirstOrDefaultAsync();
        }

        Disposer?.Push(Database, Record);
        return new EntityUpdateOut<TEntity> {
            Previous = old,
            Updated = current ?? Record,
        };
    }

    #endregion

    #region Delete

    public Task<SetBatchOut<TEntity>> Delete(TEntity[] Sets) {

        TEntity[] safe = [];
        SetOperationFailure<TEntity>[] fails = [];

        foreach (TEntity set in Sets) {
            try {
                set.EvaluateWrite();
                safe = [.. safe, set];
            } catch (Exception excep) {
                SetOperationFailure<TEntity> fail = new(set, excep);
                fails = [.. fails, fail];
            }
        }

        Set.RemoveRange(safe);
        return Task.FromResult<SetBatchOut<TEntity>>(new(safe, []));
    }

    public async Task<TEntity> Delete(TEntity Set) {
        Set.EvaluateWrite();
        _ = this.Set.Remove(Set);
        _ = await Database.SaveChangesAsync();
        Database.ChangeTracker.Clear();
        return Set;
    }

    public async Task<TEntity> Delete(long Id) {
        TEntity record = await Set
            .AsNoTracking()
            .Where(r => r.Id == Id)
            .FirstOrDefaultAsync()
            ?? throw new Exception("Trying to remove an unexist entity");

        Set.Remove(record);
        await Database.SaveChangesAsync();

        return record;
    }

    #endregion
}