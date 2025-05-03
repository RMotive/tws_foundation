
using System.Linq.Expressions;

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
    protected readonly TDepot Depot;

    readonly QueryProcessor<TEntity>? PreOperation;

    readonly QueryProcessor<TEntity>? PostOperation;

    public BService(TDepot Depot, QueryProcessor<TEntity>? preOperation = null, QueryProcessor<TEntity>? postOperation = null) {
        this.Depot = Depot;
        PreOperation = preOperation;
        PostOperation = postOperation;
    }

    protected OperationInput<TEntity, TParameters> GetOperationInput<TParameters>(TParameters parameters)
    => new() {
        Parameters = parameters,
        PreOperation = PreOperation,
        PostOperation = PostOperation
    };

    public virtual Task<ViewOutput<TEntity>> View(OperationInput<TEntity, ViewInput<TEntity>> input) {
        return Depot.View(input);
    }

    public virtual Task<BatchOperationOutput<TEntity>> Create(TEntity[] Entities, bool Sync = false) {
        return Depot.Create(Entities, Sync);
    }

    public virtual Task<BatchOperationOutput<TEntity>> Read(EntityBatchBehaviors Behavior, Expression<Func<TEntity, bool>> Filter, QueryProcessor<TEntity>? Accumulate = null) {
        return Depot.Read(Behavior, Filter);
    }

    public virtual Task<UpdateOutput<TEntity>> Update(UpdateInput<TEntity> input) {
        return Depot.Update(
                GetOperationInput(input)
            );
    }

    public virtual Task<TEntity> Delete(long id) {
        return Depot.Delete(id);
    }

    public virtual Task<BatchOperationOutput<TEntity>> Delete(long[] ids) {
        return Depot.Delete(ids);
    }
}
