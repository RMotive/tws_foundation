using CSM_Database_Core.Depots.Models;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

namespace CSM_Foundation.Product;


/// <summary>
///     Represents a deleting logic interface for a product service. A product service usually works as
///     an operation scoped to the product business needs.
/// </summary>
/// <typeparam name="TEntity">
///     Type of the <see cref="IEntity"/> the service is based on.
/// </typeparam>
public interface IService_Delete<TEntity>
    : IService
    where TEntity : class, IEntity {


    /// <summary>
    ///     Deletes the <typeparamref name="TEntity"/> at the data storages with the given <paramref name="id"/>,
    ///     this is macthed by the <see cref="IEntity.Id"/> property.
    /// </summary>
    /// <param name="id">
    ///     Data storages unique identifier to delete.
    /// </param>
    /// <returns>
    ///     Deleted <typeparamref name="TEntity"/> data.
    /// </returns>
    Task<TEntity> Delete(long id);

    /// <summary>
    ///     Deletes the given <paramref name="entity"/> from the data storages,
    ///     this is macthed by the <see cref="IEntity.Id"/> property.
    /// </summary>
    /// <param name="entity">
    ///     <see cref="IEntity"/> to delete.
    /// </param>
    /// <returns>
    ///     Deleted <typeparamref name="TEntity"/> data.
    /// </returns>
    Task<TEntity> Delete(TEntity entity);

    /// <summary>
    ///     Deletes the collection of <typeparamref name="TEntity"/> at the data storages within the given <paramref name="ids"/>,
    ///     this is macthed by the <see cref="IEntity.Id"/> property.
    /// </summary>
    /// <param name="ids">
    ///     Data storages unique identifiers to delete.
    /// </param>
    /// <returns>
    ///     <see cref="BatchOperationOutput{T}"/> data.
    /// </returns>
    Task<BatchOperationOutput<TEntity>> Delete(long[] ids);

    /// <summary>
    ///     Deletes the collection of given <paramref name="entities"/>,
    ///     this is macthed by the <see cref="IEntity.Id"/> property.
    /// </summary>
    /// <param name="entities">
    ///     Collection of <typeparamref name="TEntity"/> to delete.
    /// </param>
    /// <returns>
    ///     <see cref="BatchOperationOutput{T}"/> data.
    /// </returns>
    Task<BatchOperationOutput<TEntity>> Delete(TEntity[] entities);
}
