
using System.Linq.Expressions;

using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Input.Update;
using CSM_Foundation.Database.Entity.Models.Output;

namespace CSM_Foundation.Customer;

public class BService<TEntity, TDepot>
    : IService<TEntity>
    where TEntity : class, IEntity
    where TDepot : IDepot<TEntity> {

    /// <summary>
    /// 
    /// </summary>
    protected readonly TDepot Depot;

    readonly AccumulateDelegate<TEntity>? PreOperation;

    readonly AccumulateDelegate<TEntity>? PostOperation;

    public BService(TDepot Depot, AccumulateDelegate<TEntity>? preOperation = null, AccumulateDelegate<TEntity>? postOperation = null) {
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

    public virtual Task<SetViewOutput<TEntity>> View(SetViewOptions<TEntity> Options, AccumulateDelegate<TEntity>? Accumulate = null) {
        return Depot.View(Options);
    }

    public virtual Task<EntityBatchOutput<TEntity, TEntity>> Create(TEntity[] Entities, bool Sync = false) {
        return Depot.Create(Entities, Sync);
    }

    public virtual Task<EntityBatchOutput<TEntity, TEntity>> Read(ReadBehaviors Behavior, Expression<Func<TEntity, bool>> Filter, AccumulateDelegate<TEntity>? Accumulate = null) {
        return Depot.Read(Behavior, Filter);
    }

    public virtual Task<EntityUpdateOutput<TEntity>> Update(UpdateInput<TEntity> input) {
        return Depot.Update(
                GetOperationInput(input)
            );
    }

    public virtual Task<EntityBatchOutput<TEntity, TEntity>> Delete(TEntity[] Entities) {
        return Depot.Delete(Entities);
    }

    public virtual Task<TEntity> Delete(long Pointer) {
        return Depot.Delete(Pointer);
    }
}
