
using System.Linq.Expressions;

using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

namespace CSM_Foundation.Customer;

public class BService<TEntity, TDepot>
    : IService<TEntity>
    where TEntity : class, IEntity
    where TDepot : IDepot<TEntity> {

    /// <summary>
    /// 
    /// </summary>
    protected readonly TDepot Depot;

    readonly AccumulateDelegate<TEntity>? Accumulator;

    public BService(TDepot Depot, AccumulateDelegate<TEntity>? Accumulate = null) {
        this.Depot = Depot;
        this.Accumulator = Accumulate;
    }

    public virtual Task<SetViewOut<TEntity>> View(SetViewOptions<TEntity> Options, AccumulateDelegate<TEntity>? Accumulate = null) {
        return Depot.View(Options, Accumulate ?? Accumulator);
    }

    public virtual Task<SetBatchOut<TEntity>> Create(TEntity[] Entities, bool Sync = false) {
        return Depot.Create(Entities, Sync);
    }

    public virtual Task<SetBatchOut<TEntity>> Read(ReadBehaviors Behavior, Expression<Func<TEntity, bool>> Filter, AccumulateDelegate<TEntity>? Accumulate = null) {
        return Depot.Read(Behavior, Filter, Accumulate ?? Accumulator);
    }

    public virtual Task<EntityUpdateOut<TEntity>> Update(TEntity Entity, AccumulateDelegate<TEntity>? Accumulate = null) {
        return Depot.Update(Entity, Accumulate ?? Accumulator);
    }

    public virtual Task<SetBatchOut<TEntity>> Delete(TEntity[] Entities) {
        return Depot.Delete(Entities);
    }

    public virtual Task<TEntity> Delete(long Pointer) {
        return Depot.Delete(Pointer);
    }
}
