using CSM_Database_Core.Entities.Abstractions.Bases;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Foundation.Product;

namespace CSM_Foundation;

public interface IReferenceService<TEntity>
    : IService<TEntity>
    where TEntity : CatalogEntityBase, IEntity {

    /// <summary>
    /// Fetch a <see cref="TEntity"/>  Record based on the provided <paramref name="reference"/> and returns the result of the operation.
    /// </summary>
    /// <param name="reference"></param>
    /// <returns></returns>
    Task<TEntity?> Read(string reference);
}
