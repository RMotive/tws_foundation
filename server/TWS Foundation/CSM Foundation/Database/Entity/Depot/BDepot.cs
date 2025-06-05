using System.Data;
using System.Linq.Expressions;
using System.Reflection;

using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Entity.Depot.IDepot_Read;
using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Depot.IDepot_View.ViewFilters;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;
using CSM_Foundation.Database.Utilitites;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.ChangeTracking;

namespace CSM_Foundation.Database.Entity.Depot;

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

    #region (Private / Protected) Functions / Methods

    /// <summary>
    ///     Processes the source enitty query over the complex pre processors validation and applying the custom querying process from each
    ///     method implementation, after that returns the fully processed query.
    /// </summary>
    /// <param name="input">
    ///     Query input parameters.
    /// </param>
    /// <param name="process">
    ///     Method scope query process.
    /// </param>
    /// <returns></returns>
    protected IQueryable<TEntity> ProcessQuery<TParameters>(QueryInput<TEntity, TParameters> input, Func<IQueryable<TEntity>, IQueryable<TEntity>> process) {
        IQueryable<TEntity> query = Set;

        if (input.PreProcessor != null) {
            query = input.PreProcessor(query);
        }

        query = process(query);

        if (input.PostProcessor != null) {
            query = input.PostProcessor(query);
        }

        return query;
    }

    /// <summary>
    ///     Applies the given <paramref name="filters"/> to the given <paramref name="query"/>.
    /// </summary>
    /// <param name="query">
    ///     Query object.
    /// </param>
    /// <param name="filters">
    ///     Filters specifications to apply.
    /// </param>
    /// <returns>
    ///     The filtered calculated 
    /// </returns>
    protected IQueryable<TEntity> FilterQuery(IQueryable<TEntity> query, IViewFilterNode<TEntity>[] filters) {
        if (filters.Length > 0) {
            var orderedFilters = filters.OrderBy(
                    (filter) => filter.Order
                );

            foreach (IViewFilterNode<TEntity> filter in orderedFilters) {
                Expression<Func<TEntity, bool>> queryExpression = filter.Compose();
                query = query.Where(queryExpression);
            }
        }

        return query;
    }

    /// <summary>
    ///     Applies and calculates pagination values to the given <paramref name="query"/>.
    /// </summary>
    /// <param name="query">
    ///     Query object.
    /// </param>
    /// <param name="page">
    ///     The page requested to get the items.
    /// </param>
    /// <param name="range">
    ///     The range of items per page to calculate.
    /// </param>
    /// <param name="export">
    ///     Wheter the current calculation is for an Exportable View.
    /// </param>
    /// <returns>
    ///     The pagination operation result information.
    /// </returns>
    protected async Task<PaginationOutput<TEntity>> PaginateQuery(IQueryable<TEntity> query, int page, int range, bool export = false) {
        int entitiesCount = await query.CountAsync();
        if (export) {

            return new PaginationOutput<TEntity> {
                Query = query,
                PagesCount = 1,
                EntitiesCount = entitiesCount,
            };
        }

        (int pages, int remainder) = Math.DivRem(entitiesCount, range);
        if (remainder > 0) {
            pages++;
        }

        int paginationStart = range * (page - 1);
        int paginationEnd = page == pages ? remainder == 0 ? range : remainder : range;
        query = query
            .AsNoTracking()
            .Skip(paginationStart)
            .Take(paginationEnd);

        return new PaginationOutput<TEntity> {
            Query = query,
            PagesCount = pages,
            EntitiesCount = entitiesCount,
        };
    }

    /// <summary>
    ///     Applies the given <paramref name="orderings"/> to the given <paramref name="query"/>.
    /// </summary>
    /// <param name="query">
    ///     Query object.
    /// </param>
    /// <param name="orderings">
    ///     Options to apply ordering to the given <paramref name="query"/>.
    /// </param>
    /// <returns>
    ///     An ordered and calculated query object.
    /// </returns>
    /// <exception cref="TypeAccessException">
    ///     When a given <see cref="ViewOrdering"/> has configured a wrong property that doesn't exist in the main <see cref="IEntity"/> declaration.
    /// </exception>
    protected IQueryable<TEntity> OrderQuery(IQueryable<TEntity> query, ViewOrdering[] orderings) {
        int orderingsCount = orderings.Length;
        if (orderingsCount <= 0) {
            return query;
        }

        Type entityDeclarationType = typeof(TEntity);
        IOrderedQueryable<TEntity> orderingQuery = default!;
        for (int orderingsIteration = 0; orderingsIteration < orderingsCount; orderingsIteration++) {
            ParameterExpression parameterExpression = Expression.Parameter(entityDeclarationType, $"X{orderingsIteration}");
            ViewOrdering ordering = orderings[orderingsIteration];

            PropertyInfo property = entityDeclarationType.GetProperty(ordering.Property)
                ?? throw new TypeAccessException($"Unexist property ({ordering.Property}) on ({entityDeclarationType})");

            MemberExpression memberExpression = Expression.MakeMemberAccess(parameterExpression, property);
            UnaryExpression translationExpression = Expression.Convert(memberExpression, typeof(object));
            Expression<Func<TEntity, object>> orderingExpression = Expression.Lambda<Func<TEntity, object>>(translationExpression, parameterExpression);
            if (orderingsIteration == 0) {
                orderingQuery = ordering.Ordering switch {
                    ViewOrderings.Ascending => query.OrderBy(orderingExpression),
                    ViewOrderings.Descending => query.OrderByDescending(orderingExpression),
                    _ => query.OrderBy(orderingExpression),
                };
                continue;
            }

            orderingQuery = ordering.Ordering switch {
                ViewOrderings.Ascending => orderingQuery.ThenBy(orderingExpression),
                ViewOrderings.Descending => orderingQuery.ThenByDescending(orderingExpression),
                _ => orderingQuery.ThenBy(orderingExpression),
            };
        }
        return orderingQuery;
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

    #endregion

    #region View 

    public async Task<ViewOutput<TEntity>> View(QueryInput<TEntity, ViewInput<TEntity>> input) {
        ViewInput<TEntity> parameters = input.Parameters;

        IQueryable<TEntity> processedQuery = ProcessQuery(
                input,
                (query) => {
                    processedQuery = OrderQuery(query, parameters.Orderings);
                    processedQuery = FilterQuery(query, parameters.Filters);

                    return query;
                }
            );

        PaginationOutput<TEntity> paginationOutput = await PaginateQuery(processedQuery, parameters.Page, parameters.Range, parameters.Export);

        return new ViewOutput<TEntity>() {
            Page = parameters.Page,
            Pages = paginationOutput.PagesCount,
            Count = paginationOutput.EntitiesCount,
            Entities = [.. paginationOutput.Query],
        };
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

        Disposer?.Push(entity);
        await Database.SaveChangesAsync();

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
    public virtual async Task<BatchOperationOutput<TEntity>> Create(ICollection<TEntity> entities, bool sync = false) {
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
        Database.SaveChanges();
        return new(attached, failures);
    }

    #endregion

    #region Read

    /// <summary>
    ///     Reads into the <see cref="TEntity"/> database [Entity] for matched records.
    /// </summary>
    /// <param name="id">
    ///     Identifier of the desired <typeparamref name="TEntity"/>.
    /// </param>
    /// <returns> <see cref="TEntity"/> insatcne found </returns>
    /// <exeption cref="XDepot">
    ///     Thrown when the <see cref="TEntity"/> couldn't be found.
    /// </exeption>
    public async Task<TEntity> Read(long id) {
        TEntity? entity = await Set.Where(
                e => e.Id == id
            )
            .FirstOrDefaultAsync()
            ?? throw new XDepot<TEntity>(XDepotSituations.Unfound, $"{nameof(IEntity.Id)} = {id}");

        entity.EvaluateRead();
        return entity;
    }

    public async Task<BatchOperationOutput<TEntity>> Read(long[] ids) {

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

        return new BatchOperationOutput<TEntity>([.. successes], [.. failures]);
    }

    public async Task<BatchOperationOutput<TEntity>> Read(QueryInput<TEntity, FilterQueryInput<TEntity>> input) {
        FilterQueryInput<TEntity> parameters = input.Parameters;

        IQueryable<TEntity> processedQuery = ProcessQuery(
                input,
                sourceQuery => {
                    sourceQuery = Set.Where(parameters.Filter);
                    return sourceQuery;
                }
            );

        if (!processedQuery.Any()) {
            return new BatchOperationOutput<TEntity>([], []);
        }

        TEntity[] resultItems = parameters.Behavior switch {
            FilteringBehaviors.First => [await processedQuery.FirstAsync()],
            FilteringBehaviors.Last => [await processedQuery.Order().LastAsync()],
            FilteringBehaviors.All => await processedQuery.ToArrayAsync(),
            _ => throw new NotImplementedException(),
        };

        List<TEntity> successes = [];
        List<EntityOperationFailure<TEntity>> failures = [];
        foreach (TEntity item in resultItems) {
            try {
                item.EvaluateRead();
                successes.Add(item);
            } catch (Exception exception) {
                EntityOperationFailure<TEntity> failure = new(item, exception);
                failures.Add(failure);
            }
        }

        if (parameters.Behavior == FilteringBehaviors.First && failures.Count > 0) {
            throw failures[0].Exception;
        }

        return new BatchOperationOutput<TEntity>(
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
    /// <param name="input">
    ///     Operation input parameters.
    /// </param>
    /// <returns></returns>
    /// <remarks>
    ///     Always the record to be overriden will be defined by the <see cref="IEntity.Id"/> property, if isn't given, will try with <see cref="INamedEntity.Name"/> property in case the
    ///     [Entity] implementation does have it, otherwise will finally create a new record with the given values.
    /// </remarks>
    /// <exception cref="XDepot{TEntity}">
    ///     <see cref="IDepot{TEntity}"/> related exception.
    /// </exception>
    public async Task<UpdateOutput<TEntity>> Update(QueryInput<TEntity, UpdateInput<TEntity>> input) {
        UpdateInput<TEntity> parameters = input.Parameters;
        IQueryable<TEntity> processedQuery = Set;

        TEntity overwritten = parameters.Entity;
        if (overwritten.Id == 0) {
            if (!parameters.Create) {
                throw new XDepot<TEntity>(XDepotSituations.CreateDisabled);
            }

            overwritten = await Create(overwritten);

            Database.SaveChanges();
            Disposer?.Push(overwritten);
            return new UpdateOutput<TEntity> {
                Original = null,
                Updated = overwritten,
            };
        }

        TEntity? original = await processedQuery
            .Where(r => r.Id == overwritten.Id)
            .AsNoTracking()
            .FirstOrDefaultAsync()
            ?? throw new XDepot<TEntity>(XDepotSituations.Unfound);
        if (original == null) {
            if (!parameters.Create)
                throw new XDepot<TEntity>(XDepotSituations.Unfound, $"{typeof(TEntity).Name}.Id = {overwritten.Id}");

            overwritten = await Create(overwritten);

            Database.SaveChanges();
            Disposer?.Push(overwritten);
            return new UpdateOutput<TEntity> {
                Original = null,
                Updated = overwritten,
            };
        }

        UpdateHelper(original, overwritten);
        Database.SaveChanges();
        Disposer?.Push(overwritten);
        return new UpdateOutput<TEntity> {
            Original = original,
            Updated = overwritten,
        };
    }

    #endregion

    #region Delete

    /// <summary>
    ///     Deletes the <see cref="TEntity"/> record based on its <see cref="IEntity.Id"/> value.
    /// </summary>
    /// <param name="Id">
    ///     <see cref="IEntity.Id"/> to match.
    /// </param>
    /// <returns>
    ///     Deleted <see cref="TEntity"/> record.
    /// </returns>
    /// <exception cref="XDepot{TEntity}">
    ///     <see cref="IDepot{TEntity}"/> based exception, more info see inner Situation.
    /// </exception>
    public async Task<TEntity> Delete(long id) {
        TEntity entity = await Set
            .AsNoTracking()
            .FirstOrDefaultAsync(
                e => e.Id == id
            )
            ?? throw new XDepot<TEntity>(XDepotSituations.Unfound, $"{typeof(TEntity).Name}.Id = {id}");

        Set.Remove(entity);
        Database.SaveChanges();
        return entity;
    }


    public async Task<BatchOperationOutput<TEntity>> Delete(long[] ids) {
        List<TEntity> successes = [];
        List<EntityOperationFailure<TEntity>> failures = [];
        foreach (long id in ids) {

            try {
                TEntity success = await Delete(id);
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

        return new BatchOperationOutput<TEntity>([.. successes], [.. failures]);
    }

    public async Task<BatchOperationOutput<TEntity>> Delete(QueryInput<TEntity, FilterQueryInput<TEntity>> input) {
        FilterQueryInput<TEntity> parameters = input.Parameters;

        IQueryable<TEntity> query = ProcessQuery(
                input,
                (query) => {
                    return query
                        .AsNoTracking()
                        .Where(parameters.Filter);
                }
            );

        List<TEntity> successes = [];
        List<EntityOperationFailure<TEntity>> failures = [];
        foreach (TEntity entity in query) {
            try {
                TEntity deletedEntity = await Delete(entity.Id);
                successes.Add(deletedEntity);
            } catch (Exception exception) {
                failures.Add(
                        new EntityOperationFailure<TEntity>(entity, exception)
                    );
            }
        }

        return new BatchOperationOutput<TEntity>([.. successes], [.. failures]);
    }

    #endregion
}