using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Disposing;
using CSM_Foundation.Database.Utilitites;

using Microsoft.EntityFrameworkCore;

namespace CSM_Foundation.Database.Quality;

/// <summary>
///     Public Delegate for [Entity] factory [Quality] purposes.
/// </summary>
/// <typeparam name="TEntity">
///     Type of the [Entity] to build.
/// </typeparam>
/// <param name="Entropy">
///     Random 16 length <see cref="string"/> to generate unique properties records.
/// </param>
/// <returns>
///     The Entity stored in the database.
/// </returns>
public delegate TEntity EntityFactory<TEntity>(string Entropy)
    where TEntity : class, IEntity;

/// <summary>
///     [Abstract] for Quality Suits implementations that uses database data direct handling to store data for testing purposes.
/// </summary>
/// <remarks>
///     All stored data is being removed from a <see cref="Q_Disposer"/>. Testing data purposes can't be hold in the datasources.
/// </remarks>
public class BQ_DataHandler
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
    public BQ_DataHandler(params DatabaseFactory[] Factories) {
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


    #region Storing

    /// <summary>
    ///     Stores the given <paramref name="Entity"/> into the database.
    /// </summary>
    /// <typeparam name="TEntity2">
    ///     Type of the [Entity] to store.
    /// </typeparam>
    /// <param name="Entity">
    ///     [Entity] object instance properties to store into the database.
    /// </param>
    /// <returns>
    ///     The stored and updated [Entity] object values. 
    /// </returns>
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
    protected TEntity2 Store<TEntity2>(EntityFactory<TEntity2> EntityFactory)
        where TEntity2 : class, IEntity {

        TEntity2 toStore = RunEntityFactory(EntityFactory);
        toStore = Store(toStore);

        return toStore;
    }

    /// <summary>
    ///     Iterates based on <paramref name="Quantity"/> to generate [Entities] to store based on <paramref name="EntityFactory"/>.
    /// </summary>
    /// <typeparam name="TEntity2">
    ///     Type of the [Entity] to store.
    /// </typeparam>
    /// <param name="Quantity">
    ///     Quantity of iterations to call <paramref name="EntityFactory"/> and store the factory result.
    /// </param>
    /// <param name="EntityFactory">
    ///     Factory to build the [Entity] to store.
    /// </param>
    /// <returns>
    ///     The stored and updated [Entities] stored.
    /// </returns>
    protected async Task<TEntity2[]> Store<TEntity2>(int Quantity, EntityFactory<TEntity2> EntityFactory)
        where TEntity2 : class, IEntity, new() {

        List<TEntity2> entities = [];

        using DbContext database = GetDatabase(new TEntity2().Database);
        for (int i = 0; i < Quantity; i++) {

            TEntity2 entity = RunEntityFactory(EntityFactory);
            entity = DatabaseUtilities.SanitizeEntity(database, entity);
            entities.Add(entity);
        }

        await database.Set<TEntity2>().AddRangeAsync(entities);
        await database.SaveChangesAsync();
        Disposer.Push([.. entities]);

        return [.. entities];
    }

    #endregion

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
    DbContext GetDatabase(Type databaseType) {
        return !Factories.TryGetValue(databaseType, out DatabaseFactory? factory)
            ? throw new Exception($"No factory subscribed for [({databaseType.Name})]")
            : factory();
    }
}
