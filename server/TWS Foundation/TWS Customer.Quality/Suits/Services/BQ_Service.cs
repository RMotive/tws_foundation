using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Quality.Tools;

using TWS_Customer.Services;

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
///     Database that holds the <see cref="IEntity"/> related to the <see cref="TService"/>.
/// </typeparam>
public abstract class BQ_Service<TService, TDatabase>
    : IDisposable
    where TService : IService<IEntity>
    where TDatabase : BDatabase_SQLServer<TDatabase>, new() {

    /// <summary>
    ///     Quality suit implementation service.
    /// </summary>
    protected readonly TService Service;

    /// <summary>
    ///     Record disposer for test data.
    /// </summary>
    protected readonly QDisposer Disposer;

    /// <summary>
    ///     Database that holds the <see cref="IEntity"/> this implementation is based on. Usually to handle test data creation and direct disposition.
    /// </summary>
    protected readonly TDatabase Database = new();

    /// <summary>
    ///     Creates a new base quality implementation for a Service Quality Suit.
    /// </summary>
    /// <param name="Service">
    ///     Service based implementation.
    /// </param>
    public BQ_Service(TService Service) {
        this.Service = Service;

        Disposer = new QDisposer {
            Factory = () => Database,
        };
    }
    public void Dispose() {
        Disposer.Dispose();
        GC.SuppressFinalize(this);
    }

    public TEntity Store<TEntity>(TEntity Entity)
        where TEntity : class, IEntity {

        Database.Set<TEntity>().Add(Entity);
        Database.SaveChanges();
        Disposer.Push(Entity);

        return Entity;
    }
}
