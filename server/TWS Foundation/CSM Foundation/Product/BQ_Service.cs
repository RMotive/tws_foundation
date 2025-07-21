using CSM_Foundation.Database;
using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Quality.Disposing;

using Xunit;

namespace CSM_Foundation.Product;


/// <summary>
///     Represents a testing suit and base for <see cref="IService"/> implementations.
/// </summary>
/// <typeparam name="TService">
///     Type of the <see cref="IService"/> implementation to be tested.
/// </typeparam>
public abstract class BQ_Service<TService>
    : BQ_DataHandler
    where TService : IService {


    /// <summary>
    ///     Service instance to qualify operations.
    /// </summary>
    protected readonly TService service;

    /// <summary>
    ///     Creates a new <see cref="BQ_Service{TService}"/> instance.
    /// </summary>
    /// <param name="databaseFactories">
    ///     Databases factories from all the created entities can became. (this is mainly used for multi-databases solutions where some entities are related to another ones but came from different databases instances)
    /// </param>
    public BQ_Service(params DatabaseFactory[] databaseFactories)
        : base(databaseFactories) {

        service = ServiceFactory();
    }


    /// <summary>
    ///     Creates a new <typeparamref name="TService"/> instance that is <see cref="IService"/> 
    ///     implementation to be tested.
    /// </summary>
    /// <returns>
    ///     A new <typeparamref name="TService"/> instance.
    /// </returns>
    protected abstract TService ServiceFactory();
}


/// <summary>
///     Represents a testing suit and base for <see cref="IService{TEntity}"/> implementations.
/// </summary>
/// <typeparam name="TService">
///     Type of the <see cref="IService{TEntity}"/> implementation to be tested.
/// </typeparam>
public abstract class BQ_Service<TService, TEntity>
    : BQ_Service<TService>
    where TService : IService<TEntity>
    where TEntity : class, IEntity {

    /// <summary>
    ///     Creates a new <see cref="BQ_Service{TService}"/> instance.
    /// </summary>
    /// <param name="databaseFactories">
    ///     Databases factories from all the created entities can became. (this is mainly used for multi-databases solutions where some entities are related to another ones but came from different databases instances)
    /// </param>
    public BQ_Service(params DatabaseFactory[] databaseFactories)
        : base(databaseFactories) {
    }


    /// <summary>
    ///     Creates a new <typeparamref name="TEntity"/> sample instance. 
    /// </summary>
    /// <returns>
    ///     A new <typeparamref name="TEntity"/> data.
    /// </returns>
    /// <remarks>
    ///     This data is not saved in live data stores is only sample data.
    /// </remarks>
    protected abstract TEntity SampleEntity(string entropy);



    [Fact(DisplayName = "[Create]: Creates a single entity")]
    public async Task Create() {
        TEntity sampleEntity = RunEntityFactory(SampleEntity);

        TEntity createdEntity = await service.Create(sampleEntity);


        Assert.True( createdEntity.Id > 0, $"Created entity Id must be greater than 0" );
    }
}
