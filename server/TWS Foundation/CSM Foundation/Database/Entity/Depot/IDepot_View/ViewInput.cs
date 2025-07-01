using CSM_Foundation.Database.Entity.Depot.IDepot_View.ViewFilters;
using CSM_Foundation.Database.Entity.Models.Input;

namespace CSM_Foundation.Database.Entity.Depot.IDepot_View;

/// <summary>
///     Defines options to build a [View]
///     specifing the behavior to the builder.
/// </summary>
public class ViewInput<T>
    where T : IEntity {

    /// <summary>
    ///     On <see langword="true"/> indicate that the builder should consider all the new items added 
    ///     after the <see cref="Timestamp"/> if it is null then won't consider the limitation will behave
    ///     as this property is <see langword="true"/>
    /// </summary>
    public required bool Retroactive { get; init; }

    /// <summary>
    ///     Specifies the amount of items expected per page
    /// </summary>
    public required int Range { get; init; }

    /// <summary>
    ///     Specifies the current desired page.
    /// </summary>
    public required int Page { get; init; }

    /// <summary>
    ///     Specifies the last time this view was created, this works to limit the new entries 
    ///     on demand by <see cref="Retroactive"/>
    /// </summary>
    public DateTime? Timestamp { get; init; }

    /// <summary>
    ///     Indicates if the current options are to generate an [Export] result.
    /// </summary>
    public bool Export { get; set; } = false;

    /// <summary>
    ///     Indicates order actions to perform to the current view building.
    ///     <br>
    ///         The ordering actions will be performed by the array received order.
    ///     </br>
    /// </summary>
    public ViewOrdering[] Orderings { get; init; } = [];

    /// <summary>
    ///     How the [View] data will be filtered.
    /// </summary>
    public IViewFilterNode<T>[] Filters { get; init; } = [];
}
