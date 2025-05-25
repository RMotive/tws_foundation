namespace CSM_Foundation.Database.Entity.Depot.IDepot_Update;

/// <summary>
///     [Record] for single <typeparamref name="TEntity"/> update operation.
/// </summary>
/// <typeparam name="TEntity">
///     Type of the <see cref="IEntity"/> to update.
/// </typeparam>
public record UpdateInput<TEntity>
    where TEntity : class, IEntity {

    /// <summary>
    ///     [Entity] to update.
    /// </summary>
    public required TEntity Entity { get; init; }

    /// <summary>
    ///     Wheter the record should be created if it doesn't exist in the database.
    /// </summary>
    public bool Create { get; init; } = false;
}
