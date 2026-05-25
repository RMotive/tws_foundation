using CSM_Database_Core.Core.Utils;
using CSM_Database_Core.Entities.Abstractions.Bases;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Database_Testing.Abstractions.Bases;
using CSM_Database_Testing.Disposing;
using CSM_Database_Testing.Disposing.Abstractions.Bases;

using CSM_Foundation_Core.Core.Utils;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Bases;

namespace TWS_Business.Quality.Q_Depots.Bases;

/// <summary>
///     [Abstract] for Quality Suits implementations that uses database data direct handling to store data for testing purposes.
/// </summary>
/// <remarks>
///     All stored data is being removed from a <see cref="Q_Disposer"/>. Testing data purposes can't be hold in the datasources.
/// </remarks>

public class BQ_CommonDataHandler
    : TestingDisposer {

    /// <summary>
    ///     Quality disposition data manager, used to store to-remove entries after tests finished.
    /// </summary>
    protected readonly TestingDisposer Disposer;

    /// <summary>
    ///     Database factories available for Samples Storing/Disposing.
    /// </summary>
    protected readonly Dictionary<Type, DatabaseFactory> Factories = [];

    /// <summary>
    ///     Creates a new <see cref="BQ_DataHandler{TDatabase}"/> instance.
    /// </summary>
    /// <param name="Factories">
    ///     Collection of databases factories available for the handler to operate data.
    /// </param>
    public BQ_CommonDataHandler(params DatabaseFactory[] Factories) {
        foreach (DatabaseFactory factory in Factories) {
            using DbContext dbContext = factory();
            Type dbType = dbContext.GetType();

            this.Factories.Add(dbType, factory);
        }

        Disposer = new TestingDisposer(Factories);
    }

    /// <summary>
    ///     Internal runner for <see cref="EntityFactory{TEntity}"/> utilizations, automatically sends the [Entropy] parameter. 
    /// </summary>
    /// <typeparam name="TEntity2">
    ///     Type of the [Entity] build by the <paramref name="Factory"/>.
    /// </typeparam>
    /// <param name="Factory">
    ///     [Entity] factory function.
    /// </param>
    /// <returns>
    ///     The generated [Entity] object.
    /// </returns>
    protected static TEntity2 RunEntityFactory<TEntity2>(EntityFactory<TEntity2> Factory)
        where TEntity2 : class, IEntity {

        return Factory(RandomUtils.String(16));
    }

    /// <summary>
    ///    Retrieves the database instance for the given <paramref name="databaseType"/> based on the subscribed DatabaseFactories.
    /// </summary>
    /// <param name="databaseType">
    ///     <see cref="Type"/> of the database requested.
    /// </param>
    /// <returns>
    ///     The matched <see cref="Type"/> database context instance.
    /// </returns>
    /// <exception cref="Exception">
    ///     Thrown when the requested database <see cref="Type"/> isn't found in the subcribed database factories.
    /// </exception>
    private DbContext GetDatabase(Type databaseType) {
        return !Factories.TryGetValue(databaseType, out DatabaseFactory? factory)
            ? throw new Exception($"No factory subscribed for [({databaseType.Name})]")
            : factory();
    }



    #region Storing

    protected async Task<TEntity2> Store<TEntity2>(TEntity2 Entity)
        where TEntity2 : class, IEntity {

        DbContext database = GetDatabase(Entity.Database);

        Entity = await DatabaseUtils.SanitizeEntity(database, Entity);
        database.Set<TEntity2>().Add(Entity);
        database.SaveChanges();
        Disposer.Push(Entity);

        return Entity;
    }

    /// <summary>
    ///     Stores the [Entity] resulted by the <paramref name="EntityFactory"/>.
    /// </summary>
    /// <typeparam name="TEntity2">
    ///     Type of the [Entity] to store.
    /// </typeparam>
    /// <param name="EntityFactory">
    ///     Factory to build the [Entity] to store.
    /// </param>
    /// <returns>
    ///     The stored and updated [Entity] object. 
    /// </returns>
    protected async Task<TCommon> Store<TCommon, TInternalEdge, TExternalEdge>(EntityFactory<TCommon> EntityFactory)
        where TCommon : BCommonEntity<TInternalEdge, TExternalEdge>, new()
        where TInternalEdge : PartnerScopeEntityBase<TCommon>
        where TExternalEdge : PartnerScopeEntityBase<TCommon> {

        using DbContext database = GetDatabase(new TCommon().Database);
        TCommon toStore = RunEntityFactory(EntityFactory);

        TInternalEdge? internalRelation = toStore.Internal;
        TExternalEdge? externalRelation = toStore.External;

        toStore.Internal = default;
        toStore.External = default;

        toStore = await DatabaseUtils.SanitizeEntity(database, toStore);

        await database.AddAsync(toStore);
        Disposer.Push(toStore);

        if (internalRelation != null) {

            internalRelation = await DatabaseUtils.SanitizeEntity(database, internalRelation);
            internalRelation.Bridge = toStore;
            internalRelation.Timestamp = DateTime.UtcNow;

            await database.Set<TInternalEdge>().AddAsync(internalRelation);
            Disposer.Push(internalRelation);
            toStore.Internal = internalRelation;

            await database.SaveChangesAsync();
            return toStore;
        }

        externalRelation = await DatabaseUtils.SanitizeEntity(database, externalRelation);
        externalRelation!.Timestamp = DateTime.UtcNow;
        externalRelation.Bridge = toStore;

        await database.Set<TExternalEdge>().AddAsync(externalRelation);
        Disposer.Push(externalRelation);

        toStore.External = externalRelation;
        await database.SaveChangesAsync();

        return toStore;

    }


    protected async Task<TCommon[]> Store<TCommon, TInternalEdge, TExternalEdge>(int Quantity, EntityFactory<TCommon> EntityFactory)
        where TCommon : BCommonEntity<TInternalEdge, TExternalEdge>, new()
        where TInternalEdge : PartnerScopeEntityBase<TCommon>
        where TExternalEdge : PartnerScopeEntityBase<TCommon> {

        TCommon[] entities = [];
        using DbContext database = GetDatabase(new TCommon().Database);
        for (int i = 0; i < Quantity; i++) {

            TCommon entity = RunEntityFactory(EntityFactory);
            TInternalEdge? internalRelation = entity.Internal;
            TExternalEdge? externalRelation = entity.External;

            entity.Internal = null;
            entity.External = null;

            entity = await DatabaseUtils.SanitizeEntity(database, entity);
            database.Set<TCommon>().Add(entity);
            Disposer.Push(entity);

            if (internalRelation != null) {
                internalRelation = await DatabaseUtils.SanitizeEntity(database, internalRelation);
                internalRelation.Bridge = entity;
                internalRelation.Timestamp = DateTime.UtcNow;

                database.Set<TInternalEdge>().Add(internalRelation);

                entity.Internal = internalRelation;
                Disposer.Push(internalRelation);
                entities = [.. entities, entity];

                continue;
            }

            externalRelation!.EvaluateWrite();

            externalRelation = await DatabaseUtils.SanitizeEntity(database, externalRelation);
            externalRelation.Timestamp = DateTime.UtcNow;
            externalRelation.Bridge = entity;

            database.Set<TExternalEdge>().Add(externalRelation);

            entity.External = externalRelation;
            Disposer.Push(externalRelation);
            entities = [.. entities, entity];
        }

        await database.SaveChangesAsync();
        return entities;
    }

    #endregion

}
