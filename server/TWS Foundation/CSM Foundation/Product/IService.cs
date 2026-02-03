using CSM_Database_Core.Entities.Abstractions.Interfaces;

namespace CSM_Foundation.Product;


/// <summary>
///     Represents a product service that holds specific business logic.
/// </summary>
public interface IService { }

/// <summary>
///     Represents a product service that holds specific business logic.
/// </summary>
/// <typeparam name="TEntity">
///     Type of the <see cref="IEntity"/> the service is based on.
/// </typeparam>
public interface IService<TEntity>
    : IService,
    IService_Create<TEntity>,
    IService_Read<TEntity>,
    IService_Update<TEntity>,
    IService_Delete<TEntity>,
    IService_View<TEntity>
    where TEntity : class, IEntity {
}