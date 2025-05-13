using System.Linq.Expressions;

using CSM_Foundation.Database.Entity.Depot;

namespace CSM_Foundation.Database.Entity.Models.Input;

/// <summary>
///     [Record] object for <see cref="IEntity"/> batch operation parameters input.
/// </summary>
/// <typeparam name="TEntity">
///     Type of the <see cref="IEntity"/> the operation is based on.
/// </typeparam>
public record BatchOperationInput<TEntity>
    where TEntity : class, IEntity {

    /// <summary>
    ///     How the query items selection will behave.
    /// </summary>
    public EntityBatchBehaviors Behavior { get; init; } = EntityBatchBehaviors.All;

    /// <summary>
    ///     Filter to find the desired items.
    /// </summary>
    public required Expression<Func<TEntity, bool>> Filter { get; init; }
}
