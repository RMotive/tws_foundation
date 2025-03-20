namespace CSM_Foundation.Database.Entity.Models.Output;

/// <summary>
///     [Record] for the output of an entity [Update] operation.
/// </summary>
/// <typeparam name="TEntity"></typeparam>
public record EntityUpdateOutput<TEntity>
    where TEntity : IEntity {
    /// <summary>
    ///     The new updated <typeparamref name="TEntity"/> instance.
    /// </summary>
    public required TEntity Updated { get; set; }

    /// <summary>
    ///     The original <typeparamref name="TEntity"/> instance before the update operation.
    /// </summary>
    /// <remarks>
    ///     This property depends on the operation parameters and if there was an original entity before the update operation.
    /// </remarks>
    public TEntity? Original { get; set; }
}
