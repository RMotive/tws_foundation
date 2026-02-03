using CSM_Database_Core.Depots.Models;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

namespace CSM_Foundation.Product;


/// <summary>
///     Represents a viewing logic interface for a product service. A product service usually works as
///     an operation scoped to the product business needs.
/// </summary>
/// <typeparam name="TEntity">
///     Type of the <see cref="IEntity"/> the service is based on.
/// </typeparam>
public interface IService_View<TEntity>
    : IService
    where TEntity : class, IEntity {


    /// <summary>
    ///     Generates a View of <see cref="TEntity"/>,
    /// </summary>
    /// <param name="input">
    ///     <see cref="QueryInput{TEntity, TParameters}"/> data.
    /// </param>
    /// <returns>
    ///     <see cref="ViewOutput{TEntity}"/> data.
    /// </returns>
    Task<ViewOutput<TEntity>> View(QueryInput<TEntity, ViewInput<TEntity>> input);
}
