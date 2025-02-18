using CSM_Foundation.Database.Entity;

namespace CSM_Foundation.Database.Models.Out;

/// <summary>
///     
/// </summary>
/// <typeparam name="TEntity"></typeparam>
public class EntityUpdateOut<TEntity>
    where TEntity : IEntity {
    /// <summary>
    /// 
    /// </summary>
    public required TEntity Updated { get; set; }
    /// <summary>
    /// 
    /// </summary>
    public TEntity? Previous { get; set; }
}
