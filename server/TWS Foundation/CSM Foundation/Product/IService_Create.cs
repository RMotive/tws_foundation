using CSM_Database_Core.Depots.Models;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

namespace CSM_Foundation.Product;


/// <summary>
///     Represents a creation logic interface for a product service that holds specific business logic.
/// </summary>
/// <typeparam name="TEntity">
///     Type of the <see cref="IEntity"/> the service is based on.
/// </typeparam>
public interface IService_Create<TEntity>
    : IService
    where TEntity : class, IEntity {

    /// <summary>
    ///     Creates the given <paramref name="entity"/> into live data storages.
    /// </summary>
    /// <param name="entity">
    ///     Entity to store.
    /// </param>
    /// <returns>
    ///     Stored entity with laoded <see cref="IEntity.Id"/>.
    /// </returns>
    Task<TEntity> Create(TEntity entity);

    /// <summary>
    ///     Creates the given <paramref name="entities"/> collection into live data storages.
    /// </summary>
    /// <param name="entities">
    ///     Collection of entities to store in data storages.
    /// </param>
    /// <param name="sync">
    ///     Whether the operation must finish at the first failure caught, throwing instantly an exception.
    /// </param>
    /// <returns>
    ///    <see cref="BatchOperationOutput{T}"/> data.
    /// </returns>
    /// <remarks>
    ///     Property <see cref="IEntity.Timestamp"/> is always overriden before saving the data to 
    ///     set the <see cref="DateTime.UtcNow"/> in order to get the most accurate creation timemark.
    /// </remarks>
    Task<BatchOperationOutput<TEntity>> Create(TEntity[] entities, bool sync = false);
}
