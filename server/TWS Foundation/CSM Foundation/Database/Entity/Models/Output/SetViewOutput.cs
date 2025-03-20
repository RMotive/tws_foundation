namespace CSM_Foundation.Database.Entity.Models.Output;

/// <summary>
///     Stores a result <see cref="SetViewOutput{TMigrationSet}"/> 
///     after a build operation determining paging, filtering and ordering.
/// </summary>
/// <typeparam name="TEntity">
///     <typeparamref name="TEntity"/> that this view handles results.
/// </typeparam>
public class SetViewOutput<TEntity>
    where TEntity : IEntity {

    TEntity[] _Records = [];
    /// <summary>
    ///     The collection of items gathered.
    /// </summary>
    public required TEntity[] Records {
        get => _Records;
        init {
            _Records = value;
            Length = value.Length;
        }
    }
    /// <summary>
    ///     The available pages.
    /// </summary>
    public required int Pages { get; init; }

    /// <summary>
    ///     The current page.
    /// </summary>
    public required int Page { get; init; }

    /// <summary>
    ///     Indicates the timemark when was created.
    /// </summary>
    public DateTime Timestamp { get; init; } = DateTime.UtcNow;

    /// <summary>
    ///     Indicates the quantity of records that this result contains.
    /// </summary>
    public int Length { get; init; }

    /// <summary>
    ///     Count of total records that currently exist at the live database
    /// </summary>
    public required int Count { get; init; }
}
