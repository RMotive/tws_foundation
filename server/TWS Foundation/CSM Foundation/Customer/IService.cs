using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

namespace CSM_Foundation.Customer;


public interface IService {

}

public interface IService<TEntity>
    : IService
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
    Task<ViewOutput<TEntity>> View(QueryInput<TEntity, ViewInput<TEntity>> input);

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
    Task<BatchOperationOutput<TEntity>> Create(TEntity[] Entities, bool Sync = false);

    /// <summary>
    ///     Updates the given record, this is based on the <see cref="TEntity.Id"/> pointer to identify the record to update and override the given <paramref name="Solution"/> object.
    /// </summary>
    /// <param name="Solution">
    ///     Record to update.
    /// </param>
    /// <returns>
    ///     Complex update operation result.
    /// </returns>
    Task<UpdateOutput<TEntity>> Update(UpdateInput<TEntity> input);

    /// <summary>
    /// 
    /// </summary>
    /// <param name="id"></param>
    /// <returns></returns>
    Task<TEntity> Delete(long id);

    /// <summary>
    /// 
    /// </summary>
    /// <param name="ids"></param>
    /// <returns></returns>
    Task<BatchOperationOutput<TEntity>> Delete(long[] ids);

    /// <summary>
    /// 
    /// </summary>
    /// <param name="id"></param>
    /// <returns></returns>
    Task<TEntity> Delete(TEntity entity);

    /// <summary>
    /// 
    /// </summary>
    /// <param name="ids"></param>
    /// <returns></returns>
    Task<BatchOperationOutput<TEntity>> Delete(TEntity[] entities);
}
