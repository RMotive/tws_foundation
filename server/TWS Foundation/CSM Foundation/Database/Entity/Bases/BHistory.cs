namespace CSM_Foundation.Database.Entity.Bases;

/// <summary>
///     [Abstract] class for [History] [Entity] implementation.
///     
///     A History entity is an entry in te history sequence referencing the main [Entity].
/// </summary>
public abstract class BHistory<TEntity>
    : BEntity, IHistory
    where TEntity : class, IEntity {

    public abstract override Type Database { get; init; }

    public long Sequence { get; set; }

    /// <summary>
    ///     Main [Entity] history reference.
    /// </summary>
    /// <remarks>
    ///     Auto included relation.
    /// </remarks>
    public TEntity Entity { get; set; } = default!;
}
