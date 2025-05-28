using CSM_Foundation.Database.Entity.Depot;

namespace CSM_Foundation.Database.Entity.Models.Input;

/// <summary>
///     [Record] for specific <see cref="IDepot{TEntity}"/> operations,
///     is a required parameters for operations related with database data management.
/// </summary>
public record QueryInput<TEntity, TParameters>
    where TEntity : class, IEntity {

    /// <summary>
    ///    Custom operation scope input parameters information.
    /// </summary>
    public required TParameters Parameters { get; init; }

    /// <summary>
    ///     Custom query process to apply before the operation commit.
    /// </summary>
    public QueryProcessor<TEntity>? PreProcessor { get; set; }

    /// <summary>
    ///     Custom query process to apply after the operation commit.
    /// </summary>
    public QueryProcessor<TEntity>? PostProcessor { get; set; }
}
