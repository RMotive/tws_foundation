using CSM_Foundation.Customer;
using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Quality.Disposing;

namespace TWS_Customer.Quality.Suits.Services;

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
    : BQ_DataHandler
    where TEntity : class, IEntity
    where TService : IService<TEntity> {

    /// <summary>
    ///     Quality suit implementation service.
    /// </summary>
    protected readonly TService Service;

    /// <summary>
    ///     Creates a new base quality implementation for a Service Quality Suit.
    /// </summary>
    /// <param name="Service">
    ///     Service based implementation.
    /// </param>
    public BQ_Service(TService Service, params DatabaseFactory[] Factories)
        : base(Factories) {
        this.Service = Service;
    }
}
