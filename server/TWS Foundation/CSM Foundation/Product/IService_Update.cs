using CSM_Foundation.Database;
using CSM_Foundation.Database.Entity.Depot.IDepot_Update;

namespace CSM_Foundation.Product;


/// <summary>
///     Represents an updating logic interface for a product service. A product service usually works as
///     an operation scoped to the product business needs.
/// </summary>
/// <typeparam name="TEntity">
///     Type of the <see cref="IEntity"/> the service is based on.
/// </typeparam>
public interface IService_Update<TEntity>
    : IService
    where TEntity : class, IEntity {


    /// <summary>
    ///     Updates the entity given at the <paramref name="input"/>, this is based on the <see cref="IEntity.Id"/> 
    ///     pointer to identify the entity to update and override the given <typeparamref name="TEntity"/> data.
    /// </summary>
    /// <param name="input">
    ///     <see cref="UpdateInput{TEntity}"/> data.
    /// </param>
    /// <returns>
    ///     <see cref="UpdateOutput{T}"/> data.
    /// </returns>
    Task<UpdateOutput<TEntity>> Update(UpdateInput<TEntity> input);
}
