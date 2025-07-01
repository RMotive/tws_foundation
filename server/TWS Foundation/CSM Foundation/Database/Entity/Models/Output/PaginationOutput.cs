namespace CSM_Foundation.Database.Entity.Models.Output;

/// <summary>
///     [Output] object for a pagination proccess result information.
/// </summary>
/// <remarks>
///     A pagination operation is the of calculate and apply pagination to a query object, pagination is
///     the calculation of the total count of entries at the query and available pages based on the requested page and 
///     range of items per page given.
/// </remarks>
/// <typeparam name="TEntity">
///     Type of the  <see cref="IEntity"/> query based the pagination operation was applied to.
/// </typeparam>
public record PaginationOutput<TEntity>()
    where TEntity : class, IEntity {

    /// <summary>
    ///     The total count of available pages.
    /// </summary>
    public required int PagesCount { get; set; }

    /// <summary>
    ///     The total count of items at the query.
    /// </summary>
    public required int EntitiesCount { get; set; }

    /// <summary>
    ///     The query object with the items after the pagination is applied.
    /// </summary>
    public required IQueryable<TEntity> Query { get; init; }
}
