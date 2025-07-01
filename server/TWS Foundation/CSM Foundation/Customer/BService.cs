using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

namespace CSM_Foundation.Customer;

public class BService<TEntity, TDepot>
    : IService<TEntity>
    where TEntity : BEntity
    where TDepot : IDepot<TEntity> {

    /// <summary>
    /// 
    /// </summary>
    protected readonly TDepot _depot;

    readonly QueryProcessor<TEntity>? PreOperation;

    readonly QueryProcessor<TEntity>? PostOperation;

    public BService(TDepot Depot, QueryProcessor<TEntity>? preOperation = null, QueryProcessor<TEntity>? postOperation = null) {
        this._depot = Depot;
        PreOperation = preOperation;
        PostOperation = postOperation;
    }

    protected QueryInput<TEntity, TParameters> GetOperationInput<TParameters>(TParameters parameters)
    => new() {
        Parameters = parameters,
        PreProcessor = PreOperation,
        PostProcessor = PostOperation
    };

    public virtual Task<ViewOutput<TEntity>> View(QueryInput<TEntity, ViewInput<TEntity>> input) {
        return _depot.View(input);
    }

    public virtual Task<BatchOperationOutput<TEntity>> Create(TEntity[] Entities, bool Sync = false) {
        return _depot.Create(Entities, Sync);
    }

    public virtual Task<UpdateOutput<TEntity>> Update(UpdateInput<TEntity> input) {
        return _depot.Update(
                GetOperationInput(input)
            );
    }

    public virtual Task<TEntity> Delete(long id) {
        return _depot.Delete(id);
    }

    public virtual Task<BatchOperationOutput<TEntity>> Delete(long[] ids) {
        return _depot.Delete(ids);
    }

    public virtual Task<TEntity> Delete(TEntity entity) {
        return _depot.Delete(entity);
    }

    public virtual Task<BatchOperationOutput<TEntity>> Delete(TEntity[] entities) {
        return _depot.Delete(entities);
    }
}
