using CSM_Foundation.Database.Interfaces;

namespace CSM_Foundation.Database.Models.Out;

/// <summary>
///     Stores a result <see cref="SetViewOut{TMigrationSet}"/> 
///     after a build operation determining paging, filtering and ordering.
/// </summary>
/// <typeparam name="TMigrationSet">
///     <typeparamref name="TMigrationSet"/> that this view handles results.
/// </typeparam>
public class SetViewOut<TMigrationSet>
    where TMigrationSet : ISet {

    private TMigrationSet[] _Records = [];
    /// <summary>
    ///     The collection of items gathered.
    /// </summary>
    public required TMigrationSet[] Records {
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
    public DateTime Creation { get; init; } = DateTime.UtcNow;

    /// <summary>
    ///     Indicates the quantity of records that this result contains.
    /// </summary>
    public int Length { get; init; }

    /// <summary>
    ///     Count of total records that currently exist at the live database
    /// </summary>
    public required int Count { get; init; }
}
