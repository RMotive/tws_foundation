using CSM_Foundation.Database;

namespace CSM_Foundation.Product;


/// <summary>
///     Represents a reading logic interface for a product service. A product service usually works as
///     an operation scoped to the product business needs.
/// </summary>
/// <typeparam name="TEntity">
///     Type of the <see cref="IEntity"/> the service is based on.
/// </typeparam>
public interface IService_Read<TEntity>
    : IService
    where TEntity : class, IEntity {


}
