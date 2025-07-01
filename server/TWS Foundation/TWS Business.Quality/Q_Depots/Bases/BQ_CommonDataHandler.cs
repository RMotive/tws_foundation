using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Quality.Disposing;
using CSM_Foundation.Database.Utilitites;

using Microsoft.EntityFrameworkCore;

namespace TWS_Business.Quality.Q_Depots.Bases;

/// <summary>
///     [Abstract] for Quality Suits implementations that uses database data direct handling to store data for testing purposes.
/// </summary>
/// <remarks>
///     All stored data is being removed from a <see cref="Q_Disposer"/>. Testing data purposes can't be hold in the datasources.
/// </remarks>

public class BQ_CommonDataHandler
    : IDisposable {

    /// <summary>
    ///     Quality disposition data manager, used to store to-remove entries after tests finished.
    /// </summary>
    protected readonly Q_Disposer Disposer;

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

        Disposer = new Q_Disposer(Factories);
    }

    public void Dispose() {
        Disposer.Dispose();
        GC.SuppressFinalize(this);
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

    protected TEntity2 Store<TEntity2>(TEntity2 Entity)
        where TEntity2 : class, IEntity {

        DbContext database = GetDatabase(Entity.Database);

        Entity = DatabaseUtilities.SanitizeEntity(database, Entity);
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
        where TCommon : CommonEntity<TInternalEdge, TExternalEdge>, new()
        where TInternalEdge : CommonEntityEdge<TCommon>
        where TExternalEdge : CommonEntityEdge<TCommon> {

        using DbContext database = GetDatabase(new TCommon().Database);
        TCommon toStore = RunEntityFactory(EntityFactory);

        TInternalEdge? internalRelation = toStore.Internal;
        TExternalEdge? externalRelation = toStore.External;

        toStore.Internal = null;
        toStore.External = null;

        toStore = DatabaseUtilities.SanitizeEntity(database, toStore);

        await database.AddAsync(toStore);
        Disposer.Push(toStore);

        if (internalRelation != null) {

            internalRelation = DatabaseUtilities.SanitizeEntity(database, internalRelation);
            internalRelation.Common = toStore;
            internalRelation.Timestamp = DateTime.UtcNow;

            await database.Set<TInternalEdge>().AddAsync(internalRelation);
            Disposer.Push(internalRelation);
            toStore.Internal = internalRelation;

            await database.SaveChangesAsync();
            return toStore;
        }

        externalRelation = DatabaseUtilities.SanitizeEntity(database, externalRelation);
        externalRelation!.Timestamp = DateTime.UtcNow;
        externalRelation.Common = toStore;

        await database.Set<TExternalEdge>().AddAsync(externalRelation);
        Disposer.Push(externalRelation);

        toStore.External = externalRelation;
        await database.SaveChangesAsync();

        return toStore;

    }


    protected async Task<TCommon[]> Store<TCommon, TInternalEdge, TExternalEdge>(int Quantity, EntityFactory<TCommon> EntityFactory)
        where TCommon : CommonEntity<TInternalEdge, TExternalEdge>, new()
        where TInternalEdge : CommonEntityEdge<TCommon>
        where TExternalEdge : CommonEntityEdge<TCommon> {

        List<TCommon> entities = [];

        using DbContext database = GetDatabase(new TCommon().Database);
        for (int i = 0; i < Quantity; i++) {

            TCommon entity = RunEntityFactory(EntityFactory);
            TInternalEdge? internalRelation = entity.Internal;
            TExternalEdge? externalRelation = entity.External;

            entity.Internal = null;
            entity.External = null;

            entity = DatabaseUtilities.SanitizeEntity(database, entity);
            entities.Add(entity);
            Disposer.Push(entity);

            if (internalRelation != null) {
                internalRelation = DatabaseUtilities.SanitizeEntity(database, internalRelation);
                internalRelation.Common = entity;
                internalRelation.Timestamp = DateTime.UtcNow;

                database.Set<TInternalEdge>().Add(internalRelation);

                entity.Internal = internalRelation;
                Disposer.Push(internalRelation);

                continue;
            }

            externalRelation!.EvaluateWrite();

            externalRelation = DatabaseUtilities.SanitizeEntity(database, externalRelation);
            externalRelation.Timestamp = DateTime.UtcNow;
            externalRelation.Common = entity;

            database.Set<TExternalEdge>().Add(externalRelation);

            entity.External = externalRelation;
            Disposer.Push(externalRelation);
        }

        await database.Set<TCommon>().AddRangeAsync(entities);
        await database.SaveChangesAsync();
        return [.. entities];
    }

    #endregion

}
