using System.Linq.Expressions;
using System.Reflection;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Entity.Exceptions;
using CSM_Foundation.Database.Entity.Filters;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Input.Update;
using CSM_Foundation.Database.Entity.Models.Output;
using CSM_Foundation.Database.Utilitites;

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
    where TEntity : class, IEntity, new() {

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



    #region (Private / Protected) Functions

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

    public Task<SetViewOutput<TEntity>> Processing(SetViewOptions<TEntity> Options, AccumulateDelegate<TEntity>? Accumulate = null) {
        IQueryable<TEntity> query = Set.AsNoTracking();

        query = Ordering(Options, query);

        query = Filtering(Options, query);

        query = Accumulate?.Invoke(query) ?? query;

        (IQueryable<TEntity> source, int amount, int pages, int page) = Paging(Options, query);

        query = source;

        TEntity[] sets = [.. query];

        return Task.FromResult(
            new SetViewOutput<TEntity>() {
                Count = amount,
                Pages = pages,
                Page = page,
                Records = sets,
            }
        );
    }
    protected TEntity2 ValidateDependency<TEntity2>(TEntity2 dependencyEntity)
        where TEntity2 : class, IEntity, new() {

        TEntity2? tmpDependency = dependencyEntity;
        tmpDependency = tmpDependency.Id > 0
            ? Database.Set<TEntity2>().Where(dep => dep.Id == tmpDependency.Id).FirstOrDefault()
            : throw new Exception($"Dependencies aren't allowed to be auto-created on main Entity creation, you need to create the Dependency first in its corresponding [Depot]");

        return tmpDependency is null
            ? throw new Exception($"[{GetType().Name}] entity requires [{typeof(TEntity2)}] dependency")
            : tmpDependency;
    }



    /// <summary>
    ///     Validates if the given <paramref name="accumulation"/> is invokable.
    /// </summary>
    /// <param name="query">
    ///     Main operation query to apply accumulation.
    /// </param>
    /// <param name="accumulation">
    ///     Query accumulation process to validate.
    /// </param>
    /// <returns>
    ///     The updated query.
    /// </returns>
    protected IQueryable<TEntity> ValidateAccumulation(IQueryable<TEntity> query, AccumulateDelegate<TEntity>? accumulation) {
        if (accumulation == null) {
            return query;
        }

        return accumulation(query);
    }

    #endregion

    #region View 

    public Task<SetViewOutput<TEntity>> View(SetViewOptions<TEntity> Options, AccumulateDelegate<TEntity>? Accumulate = null) {
        return Processing(Options, Accumulate);
    }

    #endregion

    #region Create

    /// <summary>
    ///     Creates a new overwritten into the dataDatabases.
    /// </summary>
    /// <param name="entity">
    ///     <see cref="TEntity"/> to store.
    /// </param>
    /// <returns> 
    ///     The stored object. (Object Id is always auto-generated)
    /// </returns>
    public virtual async Task<TEntity> Create(TEntity entity) {
        entity.Timestamp = DateTime.UtcNow;
        entity.EvaluateWrite();

        entity = DatabaseUtilities.SanitizeEntity(Database, entity);
        await Set.AddAsync(entity);

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
    ///     A <see cref="EntityBatchOut{TSet}"/> that stores a collection of failures, and successes caught.
    /// </returns>
    public virtual async Task<EntityBatchOutput<TEntity, TEntity>> Create(ICollection<TEntity> entities, bool sync = false) {
        TEntity[] attached = [];
        EntityOperationFailure<TEntity>[] failures = [];

        foreach (TEntity entity in entities) {
            try {
                TEntity attachedEntity = await Create(entity);
                attached = [.. attached, attachedEntity];
            } catch (Exception excep) {
                if (sync) {
                    throw;
                }

                EntityOperationFailure<TEntity> fail = new(entity, excep);
                failures = [.. failures, fail];
            }
        }

        return new(attached, failures);
    }

    #endregion

    #region Read

    /// <summary>
    ///     Reads into the <see cref="TEntity"/> database [Entity] for matched records.
    /// </summary>
    /// <param name="Id">
    ///     Identifier of the desired <typeparamref name="TEntity"/>.
    /// </param>
    /// <returns> <see cref="TEntity"/> insatcne found </returns>
    /// <exeption cref="XDepot">
    ///     Thrown when the <see cref="TEntity"/> couldn't be found.
    /// </exeption>
    public async Task<TEntity> Read(long Id) {
        TEntity? entity = await Set.Where(
                e => e.Id == Id
            )
            .FirstOrDefaultAsync()
            ?? throw new XDepot<TEntity>(XDepotSituations.Unfound, $"{nameof(IEntity.Id)} = {Id}");

        entity.EvaluateRead();
        return entity;
    }

    public async Task<EntityBatchOutput<TEntity, TEntity>> Read(long[] ids) {

        List<TEntity> successes = [];
        List<EntityOperationFailure<TEntity>> failures = [];
        foreach (long id in ids) {

            try {
                TEntity success = await Read(id);
                successes.Add(success);
            } catch (Exception ex) {
                failures.Add(
                        new EntityOperationFailure<TEntity>(
                                new TEntity {
                                    Id = id
                                },
                                ex
                            )
                    );
            }
        }

        return new EntityBatchOutput<TEntity, TEntity>([.. successes], [.. failures]);
    }

    public async Task<EntityBatchOutput<TEntity, TEntity>> Read(ReadBehaviors behavior, Expression<Func<TEntity, bool>> filter, AccumulateDelegate<TEntity>? postProcessing = null) {
        IQueryable<TEntity> query = Set.Where(filter);
        if (postProcessing != null) {
            query = postProcessing(query);
        }

        if (!query.Any()) {
            return new EntityBatchOutput<TEntity, TEntity>([], []);
        }

        TEntity[] items = behavior switch {
            ReadBehaviors.First => [await query.FirstAsync()],
            ReadBehaviors.Last => [await query.Order().LastAsync()],
            ReadBehaviors.All => await query.ToArrayAsync(),
            _ => throw new NotImplementedException(behavior.ToString())
        };

        List<TEntity> successes = [];
        List<EntityOperationFailure<TEntity>> failures = [];
        foreach (TEntity item in items) {
            try {
                item.EvaluateRead();
                successes.Add(item);
            } catch (Exception exception) {
                EntityOperationFailure<TEntity> failure = new(item, exception);
                failures.Add(failure);
            }
        }

        return new EntityBatchOutput<TEntity, TEntity>(
                [.. successes],
                [.. failures]
            );
    }

    #endregion

    #region Update 

    /// <summary>
    /// 
    /// </summary>
    /// <param name="original"> Lastest data set stored in db sorce. </param>
    /// <param name="overwritten"> Modified set given in update service params. This modifications must be applied to the [current] set in db source. </param>
    void UpdateHelper(IEntity original, IEntity overwritten) {
        EntityEntry previousEntry = Database.Entry(original);
        if (previousEntry.State == EntityState.Unchanged) {
            // Update the non-navigation properties.
            previousEntry.CurrentValues.SetValues(overwritten);
            foreach (NavigationEntry navigation in previousEntry.Navigations) {
                object? newNavigationValue = Database.Entry(overwritten).Navigation(navigation.Metadata.Name).CurrentValue;
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
                            MethodInfo? addMethod = previousCollection.GetType().GetMethod("Add", [itemType]);
                            // Adding the new item to Icollection.
                            _ = (addMethod?.Invoke(previousCollection, [newItemSet]));

                        }
                    }
                    // Find items to modify.
                    for (int i = 0; i < previousList.Count; i++) {
                        // For each new item stored in overwritten collection, will search for an ID match and update the overwritten.
                        foreach (object newitem in newList) {
                            if (previousList[i] is IEntity previousItem && newitem is IEntity newItemSet && previousItem.Id == newItemSet.Id) {
                                UpdateHelper(previousItem, newItemSet);
                            }
                        }
                    }
                } else if (navigation.CurrentValue == null && newNavigationValue != null) {
                    // Create a new navigation overwritten.
                    // Also update the attached navigators.
                    //AttachDate(newNavigationValue);
                    EntityEntry newNavigationEntry = Database.Entry(newNavigationValue);
                    newNavigationEntry.State = EntityState.Added;
                    navigation.CurrentValue = newNavigationValue;
                } else if (navigation.CurrentValue != null && newNavigationValue != null) {
                    // Update the existing navigation overwritten
                    if (navigation.CurrentValue is IEntity currentItemSet && newNavigationValue is IEntity newItemSet) {
                        UpdateHelper(currentItemSet, newItemSet);
                    }
                }

            }
        }

    }

    /// <summary>
    ///     Updates the given record calculating the current stored values with the given <paramref name="entity"/> to update and store the new values.
    /// </summary>
    /// <param name="Input">
    ///     Operation input parameters.
    /// </param>
    /// <returns></returns>
    /// <remarks>
    ///     Always the record to be overriden will be defined by the <see cref="IEntity.Id"/> property, if isn't given, will try with <see cref="IEntity_Name.Name"/> property in case the
    ///     [Entity] implementation does have it, otherwise will finally create a new record with the given values.
    /// </remarks>
    /// <exception cref="XDepot{TEntity}">
    ///     <see cref="IDepot{TEntity}"/> related exception.
    /// </exception>
    public async Task<EntityUpdateOutput<TEntity>> Update(OperationInput<TEntity, UpdateInput<TEntity>> Input) {
        IQueryable<TEntity> query = ValidateAccumulation(Set, Input.PreOperation);

        UpdateInput<TEntity> parameters = Input.Parameters;

        TEntity overwritten = parameters.Entity;
        if (overwritten.Id == 0) {
            if (!parameters.Create) {
                throw new XDepot<TEntity>(XDepotSituations.CreateDisabled);
            }

            overwritten = await Create(overwritten);

            Disposer?.Push(Database, overwritten);
            return new EntityUpdateOutput<TEntity> {
                Original = null,
                Updated = overwritten,
            };
        }

        TEntity? original = await query
            .Where(r => r.Id == overwritten.Id)
            .AsNoTracking()
            .FirstOrDefaultAsync()
            ?? throw new XDepot<TEntity>(XDepotSituations.Unfound);
        if (original == null) {
            if (!parameters.Create)
                throw new XDepot<TEntity>(XDepotSituations.Unfound, $"{typeof(TEntity).Name}.Id = {overwritten.Id}");

            overwritten = await Create(overwritten);

            Disposer?.Push(Database, overwritten);
            return new EntityUpdateOutput<TEntity> {
                Original = null,
                Updated = overwritten,
            };
        }

        UpdateHelper(original, overwritten);
        Disposer?.Push(Database, overwritten);
        return new EntityUpdateOutput<TEntity> {
            Original = original,
            Updated = overwritten,
        };
    }

    #endregion

    #region Delete


    public async Task<TEntity> Delete(long Id) {
        TEntity record = await Set
            .Where(r => r.Id == Id)
            .AsNoTracking()
            .FirstOrDefaultAsync()
            ?? throw new XDepot<TEntity>(XDepotSituations.Unfound, $"{typeof(TEntity).Name}.Id = {Id}");

        Set.Remove(record);
        return record;
    }

    public Task<EntityBatchOutput<TEntity, TEntity>> Delete(TEntity[] Sets) {

        TEntity[] safe = [];
        EntityOperationFailure<TEntity>[] fails = [];

        foreach (TEntity set in Sets) {
            try {
                set.EvaluateWrite();
                safe = [.. safe, set];
            } catch (Exception excep) {
                EntityOperationFailure<TEntity> fail = new(set, excep);
                fails = [.. fails, fail];
            }
        }

        Set.RemoveRange(safe);
        return Task.FromResult<EntityBatchOutput<TEntity, TEntity>>(new(safe, []));
    }

    public Task<TEntity> Delete(TEntity Set) {
        Set.EvaluateWrite();

        this.Set.Remove(Set);
        return Task.FromResult(Set);
    }

    #endregion
}