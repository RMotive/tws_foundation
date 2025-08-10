using CSM_Foundation.Database.Entity.Bases;
using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;
using CSM_Foundation.Product;

namespace CSM_Foundation;

public interface IReferenceService<TEntity>
    : IService<TEntity>
    where TEntity : BNamedReferencedEntity {

    /// <summary>
    /// Fetch a <see cref="TEntity"/>  Record based on the provided <paramref name="reference"/> and returns the result of the operation.
    /// </summary>
    /// <param name="reference"></param>
    /// <returns></returns>
    Task<BatchOperationOutput<TEntity>> Read(string reference);
}
