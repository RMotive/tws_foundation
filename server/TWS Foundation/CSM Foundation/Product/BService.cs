using CSM_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Database_Core.Depots.Models;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

namespace CSM_Foundation.Product;


/// <summary>
///     Represents a product service, providing specific business logic depending on the product context
///     and requirements.
/// </summary>
/// <typeparam name="TEntity">
///     <see cref="IEntity"/> implementation type the service handles.
/// </typeparam>
/// <typeparam name="TDepot">
///     <see cref="IDepot{TEntity}"/> implementation type the service's entity handling type is based on.
/// </typeparam>
public abstract class BService<TEntity, TDepot>
    : IService<TEntity>
    where TEntity : class, IEntity
    where TDepot : IDepot<TEntity> {

    /// <summary>
    ///    Service entity type hadling depot.
    /// </summary>
    protected readonly TDepot depot;

    /// <summary>
    ///     Global service scope pre query process operation applied to all service's operations.
    /// </summary>
    readonly QueryProcessor<TEntity>? _preProcessor;

    /// <summary>
    ///     Global service scope post query process operation applied to all service's operations.
    /// </summary>
    readonly QueryProcessor<TEntity>? _postProcessor;


    /// <summary>
    ///     Creates a new instance. 
    /// </summary>
    /// <param name="depot">
    ///     Entity type depot handler.
    /// </param>
    /// <param name="preProcessor">
    ///     Global service scope pre query process operation applied to all service's operations.
    /// </param>
    /// <param name="postProcessor">
    ///     Global service scope post query process operation applied to all service's operations.
    /// </param>
    public BService(TDepot depot, QueryProcessor<TEntity>? preProcessor = null, QueryProcessor<TEntity>? postProcessor = null) {
        this.depot = depot;
        _preProcessor = preProcessor;
        _postProcessor = postProcessor;
    }


    public virtual Task<TEntity> Create(TEntity entity)
    => depot.Create(entity);

    public virtual Task<BatchOperationOutput<TEntity>> Create(TEntity[] entities, bool sync = false)
    => depot.Create(entities, sync);


    public virtual Task<UpdateOutput<TEntity>> Update(UpdateInput<TEntity> input)
    => depot.Update(GetOperationInput(input));


    public virtual Task<TEntity> Delete(long id)
    => depot.Delete(id);

    public virtual Task<TEntity> Delete(TEntity entity)
    => depot.Delete(entity);

    public virtual Task<BatchOperationOutput<TEntity>> Delete(long[] ids)
    => depot.Delete(ids);

    public virtual Task<BatchOperationOutput<TEntity>> Delete(TEntity[] entities)
    => depot.Delete(entities);


    public virtual Task<ViewOutput<TEntity>> View(QueryInput<TEntity, ViewInput<TEntity>> input)
    => depot.View(input);


    protected QueryInput<TEntity, TParameters> GetOperationInput<TParameters>(TParameters parameters)
    => new() {
        Parameters = parameters,
        PreProcessor = _preProcessor,
        PostProcessor = _postProcessor,
    };
}
