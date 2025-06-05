using System.Linq.Expressions;

namespace CSM_Foundation.Database.Entity.Depot.IDepot_Read;


/// <summary>
///     Indicates how operations that handles a batch of <see cref="IEntity"/> will interact.
/// </summary>
public enum FilteringBehaviors {
    /// <summary>
    ///     First record found that matches.
    /// </summary>
    First,
    /// <summary>
    ///     Last record found that matches.
    /// </summary>
    Last,
    /// <summary>
    ///     All records found that match.
    /// </summary>
    All,
}

/// <summary>
///     {model} implementation to store input data to query based on filtering.
/// </summary>
public record FilterQueryInput<TEntity>
    where TEntity : class, IEntity {

    /// <summary>
    ///     How the query result match should fetch the actual results.
    /// </summary>
    public FilteringBehaviors Behavior { get; set; } = FilteringBehaviors.All;

    /// <summary>
    ///     Filtering instruction.
    /// </summary>
    public required Expression<Func<TEntity, bool>> Filter { get; set; }
}
