using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Quality.Disposing;

using Microsoft.EntityFrameworkCore;

using TWS_Customer.Services;

namespace TWS_Customer.Quality.Suits.Services;

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
///     Public Delegate for [database] factory [Quality] purposes.
/// </summary>
/// <returns>
///     The database context instance.
/// </returns>
public delegate DbContext DatabaseFactory();

/// <summary>
///     Base Quality Implementation for a Service Quality Suit.
/// </summary>
/// <typeparam name="TEntity">
///     Set service is based on.
/// </typeparam>
/// <typeparam name="TService">
///     Service type implementation based on.
/// </typeparam>
/// <typeparam name="TDatabase">
///     database that holds the <see cref="IEntity"/> related to the <see cref="TService"/>.
/// </typeparam>
public abstract class BQ_Service<TEntity, TService, TDatabase>
    : IDisposable
    where TEntity : IEntity
    where TService : IService<TEntity> {

    /// <summary>
    ///     Quality suit implementation service.
    /// </summary>
    protected readonly TService Service;

    /// <summary>
    ///     Entity disposer for test data.
    /// </summary>
    protected readonly Q_Disposer Disposer;

    /// <summary>
    ///     database factories available for Samples Storing/Disposing.
    /// </summary>
    protected readonly Dictionary<Type, DatabaseFactory> Factories = [];

    /// <summary>
    ///     Creates a new base quality implementation for a Service Quality Suit.
    /// </summary>
    /// <param name="Service">
    ///     Service based implementation.
    /// </param>
    public BQ_Service(TService Service, params DatabaseFactory[] Factories) {
        this.Service = Service;

        Disposer = new Q_Disposer();
        foreach (DatabaseFactory factory in Factories) {

            using DbContext dbContext = factory();
            Type dbType = dbContext.GetType();

            this.Factories.Add(dbType, factory);
        }
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
    private static TEntity2 RunEntityFactory<TEntity2>(EntityFactory<TEntity2> Factory)
        where TEntity2 : class, IEntity {

        return Factory(RandomUtils.String(16));
    }

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
    public TEntity2 Store<TEntity2>(TEntity2 Entity)
        where TEntity2 : class, IEntity {

        DatabaseFactory factory = Factories[Entity.Database];
        DbContext database = factory();

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
    public TEntity2 Store<TEntity2>(EntityFactory<TEntity2> EntityFactory)
        where TEntity2 : class, IEntity {

        TEntity2 toStore = RunEntityFactory(EntityFactory);
        toStore = Store(toStore);

        Disposer.Push(toStore);

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
    public TEntity2[] Store<TEntity2>(int Quantity, EntityFactory<TEntity2> EntityFactory)
        where TEntity2 : class, IEntity {

        DbContext? database = null;
        TEntity2[] entities = [];
        while (Quantity > 0) {
            Quantity--;

            TEntity2 entity = RunEntityFactory(EntityFactory);
            entities = [
                    ..entities, entity,
                ];

            if (database != null) {
                continue;
            }
            DatabaseFactory dbFactory = Factories[entity.Database];
            database = dbFactory();
        }

        if (database != null) {
            using DbContext dbContext = database;

            dbContext.Set<TEntity2>().AddRange(entities);
            dbContext.SaveChangesAsync();
        }

        return entities;
    }
}
