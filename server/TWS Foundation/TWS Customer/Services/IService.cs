using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using TWS_Security.Entities.Solutions;

namespace TWS_Customer.Services;

/// <summary>
///     Interface for Customer Service implementations.
/// </summary>
/// <typeparam name="TEntity">
///     The <see cref="Type"/> of [Set] context for the service implementation.
/// </typeparam>
public interface IService<TEntity>
    where TEntity : IEntity {

    /// <summary>
    ///     Generates a View for <see cref="TEntity"/> set,
    /// </summary>
    /// <param name="Options">
    ///     Options to determine how to build the View.
    /// </param>
    /// <returns>
    ///     The complex View results, a View is a paged and ordered collection of records based on the given <paramref name="Options"/>
    /// </returns>
    Task<SetViewOut<TEntity>> View(SetViewOptions<TEntity> Options);

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
    Task<SetBatchOut<TEntity>> Create(TEntity[] Solutions);

    /// <summary>
    ///     Updates the given record, this is based on the <see cref="TEntity.Id"/> pointer to identify the record to update and override the given <paramref name="Solution"/> object.
    /// </summary>
    /// <param name="Solution">
    ///     Record to update.
    /// </param>
    /// <returns>
    ///     Complex update operation result.
    /// </returns>
    Task<RecordUpdateOut<TEntity>> Update(TEntity Solution);

    /// <summary>
    ///     Removes from the data storage the <see cref="TEntity"/> record based on the <paramref name="Id"/> pointer.
    /// </summary>
    /// <param name="Id">
    ///     Pointer to identify record.
    /// </param>
    /// <returns>
    ///     The removed record object.
    /// </returns>
    Task<TEntity> Delete(int Id);
}
