namespace CSM_Foundation.Database.Entity;

/// <summary>
///     [Interface] for Entities that are [History] tracked and contains historical information.
/// </summary>
/// <typeparam name="THistory">
///     Type of the [History Entity] that handles the history information.
/// </typeparam>
public interface IHistorical<THistory>
    where THistory : class, IHistory {

    /// <summary>
    ///     History entries.
    /// </summary>
    ICollection<THistory> History { get; set; }
}
