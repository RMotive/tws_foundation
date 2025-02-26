using CSM_Foundation.Database.Bases;

namespace CSM_Foundation.Database.Entity;

/// <summary>
///     [Abstract] class for [History] [Entity] implementation.
///     
///     A History entity is an entry in te history sequence referencing the main [Entity].
/// </summary>
public abstract class BHistory<TEntity>
    : BEntity
    where TEntity : class, IEntity {

    public override abstract Type Database { get; init; }

    /// <summary>
    ///     History entry sequence.
    /// </summary>
    public int Sequence { get; set; }

    /// <summary>
    ///     Main [Entity] history reference.
    /// </summary>
    public TEntity Entity { get; set; } = default!;
}
