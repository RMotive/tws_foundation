using System.Linq.Expressions;

using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

namespace CSM_Foundation.Customer;

public interface IService<TEntity>
    where TEntity : class, IEntity {

    /// <summary>
    ///     Generates a View for <see cref="TEntity"/> set,
    /// </summary>
    /// <param name="Options">
    ///     Options to determine how to build the View.
    /// </param>
    /// <returns>
    ///     The complex View results, a View is a paged and ordered collection of records based on the given <paramref name="Options"/>
    /// </returns>
    Task<SetViewOut<TEntity>> View(SetViewOptions<TEntity> Options, AccumulateDelegate<TEntity>? Accumulate = null);

    /// <summary>
    ///     Creates a new <see cref="TEntity"/> set records into the data storage.
    ///     
    ///     <para>
    ///         Warning: Property <see cref="TEntity.Timestamp"/> is always overriden at the last moment before saving the record to 
    ///         set the <see cref="DateTime.UtcNow"/> in order to get the most correct creation value.
    ///     </para>
    /// </summary>
    /// <param name="Solutions">
    ///     Collection of records to create.
    /// </param>
    /// <returns>
    ///     A complex batch result that provides information related to exceptions catched, record that belongs to the exception and successes.
    /// </returns>
    Task<EntityBatchOut<TEntity>> Create(TEntity[] Entities, bool Sync = false);

    Task<EntityBatchOut<TEntity>> Read(ReadBehaviors Behavior, Expression<Func<TEntity, bool>> Filter, AccumulateDelegate<TEntity>? Accumulate = null);

    /// <summary>
    ///     Updates the given record, this is based on the <see cref="TEntity.Id"/> pointer to identify the record to update and override the given <paramref name="Solution"/> object.
    /// </summary>
    /// <param name="Solution">
    ///     Record to update.
    /// </param>
    /// <returns>
    ///     Complex update operation result.
    /// </returns>
    Task<EntityUpdateOut<TEntity>> Update(TEntity Entity, AccumulateDelegate<TEntity>? Accumulate = null);

    Task<TEntity> Delete(long Pointer);
    
    /// <summary>
    ///     Removes from the data storage the <see cref="TEntity"/> record based on the <paramref name="Id"/> pointer.
    /// </summary>
    /// <param name="Id">
    ///     Pointer to identify record.
    /// </param>
    /// <returns>
    ///     The removed record object.
    /// </returns>
    Task<EntityBatchOut<TEntity>> Delete(TEntity[] Entities);
}
