using System.Linq.Expressions;
using System.Reflection;

using CSM_Foundation.Database;
using CSM_Foundation.Database.Entity.Bases;
using CSM_Foundation.Database.Entity.Depot;
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

using TWS_Business.Bases;

namespace TWS_Business.Depots.Bases;

public class BCommonDepot<TDatabase, TInternal, TExternal, TCommon>
    : IDepot<TCommon>
    where TDatabase : BDatabase_SQLServer<TDatabase>
    where TCommon : class, ICommonEntity<TInternal, TExternal>, new()
    where TInternal : class, ICommonScopeEntity<TCommon>
    where TExternal : class, ICommonScopeEntity<TCommon> {

    /// <summary>
    /// 
    /// </summary>
    protected readonly IDisposer? _disposer;

    /// <summary>
    ///     Name to handle direct transactions (not-attached)
    /// </summary>
    protected readonly TDatabase _db;

    /// <summary>
    ///     DBSet handler into <see cref="_db"/> to handle fastlike transactions related to the <see cref="TCommon"/> 
    /// </summary>
    protected readonly DbSet<TCommon> _dbSet;

    /// <summary>
    ///     Generates a new instance of a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/> base.
    /// </summary>
    /// <param name="Database">
    ///     The <typeparamref name="TDatabase"/> that stores and handles the transactions for this <see cref="TCommon"/> concept.
    /// </param>
    public BCommonDepot(TDatabase Database, IDisposer? Disposer) {
        this._db = Database;
        this._disposer = Disposer;
        _dbSet = Database.Set<TCommon>();
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
    protected IQueryable<TCommon> ProcessQuery<TParameters>(QueryInput<TCommon, TParameters> input, Func<IQueryable<TCommon>, IQueryable<TCommon>> process) {
        IQueryable<TCommon> query = _dbSet;


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
    protected IQueryable<TCommon> FilterQuery(IQueryable<TCommon> query, IViewFilterNode<TCommon>[] filters) {
        if (filters.Length > 0) {
            var orderedFilters = filters.OrderBy(
                    (filter) => filter.Order
                );

            foreach (IViewFilterNode<TCommon> filter in orderedFilters) {
                Expression<Func<TCommon, bool>> queryExpression = filter.Compose();
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
    protected async Task<PaginationOutput<TCommon>> PaginateQuery(IQueryable<TCommon> query, int page, int range, bool export = false) {
        int entitiesCount = await query.CountAsync();
        if (export) {

            return new PaginationOutput<TCommon> {
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

        return new PaginationOutput<TCommon> {
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
    protected IQueryable<TCommon> OrderQuery(IQueryable<TCommon> query, ViewOrdering[] orderings) {
        int orderingsCount = orderings.Length;
        if (orderingsCount <= 0) {
            return query;
        }

        Type entityDeclarationType = typeof(TCommon);
        IOrderedQueryable<TCommon> orderingQuery = default!;
        for (int orderingsIteration = 0; orderingsIteration < orderingsCount; orderingsIteration++) {
            ParameterExpression parameterExpression = Expression.Parameter(entityDeclarationType, $"X{orderingsIteration}");
            ViewOrdering ordering = orderings[orderingsIteration];

            PropertyInfo property = entityDeclarationType.GetProperty(ordering.Property)
                ?? throw new TypeAccessException($"Unexist property ({ordering.Property}) on ({entityDeclarationType})");

            MemberExpression memberExpression = Expression.MakeMemberAccess(parameterExpression, property);
            UnaryExpression translationExpression = Expression.Convert(memberExpression, typeof(object));
            Expression<Func<TCommon, object>> orderingExpression = Expression.Lambda<Func<TCommon, object>>(translationExpression, parameterExpression);
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

    protected TCommon2 ValidateDependency<TCommon2>(TCommon2 dependencyEntity)
        where TCommon2 : class, IEntity, new() {

        TCommon2? tmpDependency = dependencyEntity;
        tmpDependency = tmpDependency.Id > 0
            ? _db.Set<TCommon2>().Where(dep => dep.Id == tmpDependency.Id).FirstOrDefault()
            : throw new Exception($"Dependencies aren't allowed to be auto-created on main Entity creation, you need to create the Dependency first in its corresponding [Depot]");

        return tmpDependency is null
            ? throw new Exception($"[{GetType().Name}] entity requires [{typeof(TCommon2)}] dependency")
            : tmpDependency;
    }

    /// <summary>
    /// Stores the specified common entity and its nested entities in the database.
    /// </summary>
    /// <remarks>This method processes the specified entity and its nested entities, adding them to the
    /// database. The method ensures that nested entities are stored in the correct order to maintain referential integrity.</remarks>
    /// <param name="common">The root entity to be stored. Nested entities within this entity will also be processed and stored.</param>
    /// <param name="save">A boolean value indicating whether to immediately save changes to the database. <see langword="true"/> to save
    /// changes after storing the entities; otherwise, <see langword="false"/>.</param>
    /// <returns>The root entity that was processed and stored.</returns>
    public async Task<TCommon> Store(TCommon common, bool save = false) {
        bool rootchecked = false;
        HashSet<IEntity> entitiesToAdd = [];

        StoreNestedEntities(common, common, entitiesToAdd, rootchecked);

        foreach (IEntity entity in entitiesToAdd.Reverse()) {
            if (entity.Id == 0) {
                _db.Add(entity);
                _disposer?.Push(entity);
            }
        }

        if (save) await _db.SaveChangesAsync();

        return common;
    }

    /// <summary>
    /// Recurses through the nested entities of a common entity and stores them in a hash set to avoid duplicates.
    /// </summary>
    /// <param name="commonRoot"></param>
    /// <param name="entity">Current entity to process and store.</param>
    /// <param name="entitiesHash">List of stored entities. The content is verified to avoid duplications. </param>
    /// <param name="rootChecked">Flag for first recursive run.</param>
    static void StoreNestedEntities(TCommon commonRoot, IEntity entity, HashSet<IEntity> entitiesHash, bool rootChecked) {

        if (entity == null || entitiesHash.Contains(entity)) return;

        if (!rootChecked) {
            rootChecked = true;
            if (commonRoot.Internal != null) StoreNestedEntities(commonRoot, commonRoot.Internal, entitiesHash, rootChecked);
            if (commonRoot.External != null) StoreNestedEntities(commonRoot, commonRoot.External, entitiesHash, rootChecked);
            entitiesHash.Add(commonRoot);

        } else {
            entitiesHash.Add(entity);
        }

        Type type = entity.GetType();
        foreach (PropertyInfo prop in type.GetProperties()) {
            var value = prop.GetValue(entity);

            if (value is IEntity nestedEntity) {
                StoreNestedEntities(commonRoot, nestedEntity, entitiesHash, rootChecked);
            } else if (value is IEnumerable<IEntity> collection) {
                foreach (var item in collection) {
                    StoreNestedEntities(commonRoot, item, entitiesHash, rootChecked);
                }
            }
        }

    }


    #endregion

    #region Create

    public async Task<TCommon> Create(TCommon entity) {
        entity.Timestamp = DateTime.UtcNow;
        entity.EvaluateWrite();

        TInternal? internalRelation = entity.Internal;
        TExternal? externalRelation = entity.External;

        entity.Internal = default;
        entity.External = default;

        entity = DatabaseUtilities.SanitizeEntity(_db, entity);

        await _dbSet.AddAsync(entity);
        _disposer?.Push(entity);

        if (internalRelation != null) {
            internalRelation.EvaluateWrite();

            internalRelation = DatabaseUtilities.SanitizeEntity(_db, internalRelation);
            internalRelation.Common = entity;
            internalRelation.Timestamp = DateTime.UtcNow;

            await _db.Set<TInternal>().AddAsync(internalRelation);
            _disposer?.Push(internalRelation);

            entity.Internal = internalRelation;

        } else {
            externalRelation!.EvaluateWrite();

            externalRelation = DatabaseUtilities.SanitizeEntity(_db, externalRelation);
            externalRelation.Timestamp = DateTime.UtcNow;
            externalRelation.Common = entity;

            await _db.Set<TExternal>().AddAsync(externalRelation);

            entity.External = externalRelation;
            _disposer?.Push(externalRelation);
        }

        await _db.SaveChangesAsync();

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
    public virtual async Task<BatchOperationOutput<TCommon>> Create(ICollection<TCommon> entities, bool sync = false) {
        TCommon[] attached = [];
        EntityOperationFailure<TCommon>[] failures = [];

        foreach (TCommon entity in entities) {
            try {
                TCommon attachedEntity = await Create(entity);
                attached = [.. attached, attachedEntity];
            } catch (Exception excep) {
                if (sync) {
                    throw;
                }

                EntityOperationFailure<TCommon> fail = new(entity, excep);
                failures = [.. failures, fail];
            }
        }
        _db.SaveChanges();
        return new(attached, failures);
    }

    #endregion

    #region Delete

    /// <summary>
    ///     Deletes the <see cref="TCommon"/> record based on its <see cref="IEntity.Id"/> value.
    /// </summary>
    /// <param name="Id">
    ///     <see cref="IEntity.Id"/> to match.
    /// </param>
    /// <returns>
    ///     Deleted <see cref="TCommon"/> record.
    /// </returns>
    /// <exception cref="XDepot{TCommon}">
    ///     <see cref="IDepot{TCommon}"/> based exception, more info see inner Situation.
    /// </exception>
    public async Task<TCommon> Delete(long id) {
        TCommon entity = await _dbSet
            .AsNoTracking()
            .FirstOrDefaultAsync(
                e => e.Id == id
            )
            ?? throw new XDepot<TCommon>(XDepotSituations.Unfound, $"{typeof(TCommon).Name}.Id = {id}");

        _dbSet.Remove(entity);
        _db.SaveChanges();
        return entity;
    }

    public async Task<TCommon> Delete(TCommon Entity) {
        if (Entity.Internal != null) {
            _db.Set<TInternal>().Remove(Entity.Internal!);
        } else {
            _db.Set<TExternal>().Remove(Entity.External!);
        }

        _dbSet.Remove(Entity);
        await _db.SaveChangesAsync();
        return Entity;
    }


    public async Task<BatchOperationOutput<TCommon>> Delete(long[] ids) {
        List<TCommon> successes = [];
        List<EntityOperationFailure<TCommon>> failures = [];
        foreach (long id in ids) {

            try {
                TCommon success = await Delete(id);
                successes.Add(success);
            } catch (Exception ex) {
                failures.Add(
                        new EntityOperationFailure<TCommon>(
                                new TCommon {
                                    Id = id
                                },
                                ex
                            )
                    );
            }
        }

        return new BatchOperationOutput<TCommon>([.. successes], [.. failures]);
    }

    public async Task<BatchOperationOutput<TCommon>> Delete(QueryInput<TCommon, FilterQueryInput<TCommon>> input) {
        FilterQueryInput<TCommon> parameters = input.Parameters;

        IQueryable<TCommon> query = ProcessQuery(
                input,
                (query) => {
                    return query
                        .AsNoTracking()
                        .Where(parameters.Filter);
                }
            );

        List<TCommon> successes = [];
        List<EntityOperationFailure<TCommon>> failures = [];

        TCommon[] entities = await query.ToArrayAsync();

        foreach (TCommon entity in entities) {
            try {
                TCommon deletedEntity = await Delete(entity.Id);
                successes.Add(deletedEntity);
            } catch (Exception exception) {
                failures.Add(
                        new EntityOperationFailure<TCommon>(entity, exception)
                    );
            }
        }

        return new BatchOperationOutput<TCommon>([.. successes], [.. failures]);
    }

    #endregion

    #region View

    public async Task<ViewOutput<TCommon>> View(QueryInput<TCommon, ViewInput<TCommon>> input) {
        ViewInput<TCommon> parameters = input.Parameters;

        IQueryable<TCommon> processedQuery = ProcessQuery(
                input,
                (query) => {
                    processedQuery = OrderQuery(query, parameters.Orderings);
                    processedQuery = FilterQuery(processedQuery, parameters.Filters);

                    return processedQuery.AsTracking();
                }
            );


        PaginationOutput<TCommon> paginationOutput = await PaginateQuery(processedQuery, parameters.Page, parameters.Range, parameters.Export);

        return new ViewOutput<TCommon>() {
            Page = parameters.Page,
            Pages = paginationOutput.PagesCount,
            Count = paginationOutput.EntitiesCount,
            Entities = [.. paginationOutput.Query],
        };
    }

    #endregion

    #region Read

    /// <summary>
    ///     Reads into the <see cref="TCommon"/> database [Entity] for matched records.
    /// </summary>
    /// <param name="id">
    ///     Identifier of the desired <typeparamref name="TCommon"/>.
    /// </param>
    /// <returns> <see cref="TCommon"/> insatcne found </returns>
    /// <exeption cref="XDepot">
    ///     Thrown when the <see cref="TCommon"/> couldn't be found.
    /// </exeption>
    public async Task<TCommon> Read(long id) {
        TCommon? entity = await _dbSet.Where(
                e => e.Id == id
            )
            .FirstOrDefaultAsync()
            ?? throw new XDepot<TCommon>(XDepotSituations.Unfound, $"{nameof(IEntity.Id)} = {id}");

        entity.EvaluateRead();
        return entity;
    }

    public async Task<BatchOperationOutput<TCommon>> Read(long[] ids) {

        List<TCommon> successes = [];
        List<EntityOperationFailure<TCommon>> failures = [];
        foreach (long id in ids) {

            try {
                TCommon success = await Read(id);
                successes.Add(success);
            } catch (Exception ex) {
                failures.Add(
                        new EntityOperationFailure<TCommon>(
                                new TCommon {
                                    Id = id
                                },
                                ex
                            )
                    );
            }
        }

        return new BatchOperationOutput<TCommon>([.. successes], [.. failures]);
    }

    public async Task<BatchOperationOutput<TCommon>> Read(QueryInput<TCommon, FilterQueryInput<TCommon>> input) {
        FilterQueryInput<TCommon> parameters = input.Parameters;

        IQueryable<TCommon> processedQuery = ProcessQuery(
                input,
                sourceQuery => {
                    sourceQuery = _dbSet.Where(parameters.Filter);
                    return sourceQuery;
                }
            );

        if (!processedQuery.Any()) {
            return new BatchOperationOutput<TCommon>([], []);
        }

        TCommon[] resultItems = parameters.Behavior switch {
            FilteringBehaviors.First => [await processedQuery.FirstAsync()],
            FilteringBehaviors.Last => [await processedQuery.Order().LastAsync()],
            FilteringBehaviors.All => await processedQuery.ToArrayAsync(),
            _ => throw new NotImplementedException(),
        };

        List<TCommon> successes = [];
        List<EntityOperationFailure<TCommon>> failures = [];
        foreach (TCommon item in resultItems) {
            try {
                item.EvaluateRead();
                successes.Add(item);
            } catch (Exception exception) {
                EntityOperationFailure<TCommon> failure = new(item, exception);
                failures.Add(failure);
            }
        }

        if (parameters.Behavior == FilteringBehaviors.First && failures.Count > 0) {
            throw failures[0].Exception;
        }

        return new BatchOperationOutput<TCommon>(
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
        EntityEntry previousEntry = _db.Entry(original);
        if (previousEntry.State == EntityState.Unchanged) {
            // Update the non-navigation properties.
            previousEntry.CurrentValues.SetValues(overwritten);
            foreach (NavigationEntry navigation in previousEntry.Navigations) {
                object? newNavigationValue = _db.Entry(overwritten).Navigation(navigation.Metadata.Name).CurrentValue;
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
                    EntityEntry newNavigationEntry = _db.Entry(newNavigationValue);
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
    ///     Always the record to be overriden will be defined by the <see cref="IEntity.Id"/> property, if isn't given, will try with <see cref="BNamedEntity.Name"/> property in case the
    ///     [Entity] implementation does have it, otherwise will finally create a new record with the given values.
    /// </remarks>
    /// <exception cref="XDepot{TCommon}">
    ///     <see cref="IDepot{TCommon}"/> related exception.
    /// </exception>
    public async Task<UpdateOutput<TCommon>> Update(QueryInput<TCommon, UpdateInput<TCommon>> input) {
        UpdateInput<TCommon> parameters = input.Parameters;
        IQueryable<TCommon> processedQuery = _dbSet;

        TCommon overwritten = parameters.Entity;
        if (overwritten.Id == 0) {
            if (!parameters.Create) {
                throw new XDepot<TCommon>(XDepotSituations.CreateDisabled);
            }

            overwritten = await Create(overwritten);

            _db.SaveChanges();
            _disposer?.Push(overwritten);
            return new UpdateOutput<TCommon> {
                Original = null,
                Updated = overwritten,
            };
        }

        TCommon? original = await processedQuery
            .Where(r => r.Id == overwritten.Id)
            .AsNoTracking()
            .FirstOrDefaultAsync()
            ?? throw new XDepot<TCommon>(XDepotSituations.Unfound);
        if (original == null) {
            if (!parameters.Create)
                throw new XDepot<TCommon>(XDepotSituations.Unfound, $"{typeof(TCommon).Name}.Id = {overwritten.Id}");

            overwritten = await Create(overwritten);

            _db.SaveChanges();
            _disposer?.Push(overwritten);
            return new UpdateOutput<TCommon> {
                Original = null,
                Updated = overwritten,
            };
        }

        UpdateHelper(original, overwritten);
        _db.SaveChanges();
        return new UpdateOutput<TCommon> {
            Original = original,
            Updated = overwritten,
        };
    }

    public Task<BatchOperationOutput<TCommon>> Delete(TCommon[] entities) {
        throw new NotImplementedException();
    }

    #endregion
}
