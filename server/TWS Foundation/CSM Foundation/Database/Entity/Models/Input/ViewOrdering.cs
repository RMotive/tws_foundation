using CSM_Foundation.Database.Entity.Depot.IDepot_View;

namespace CSM_Foundation.Database.Entity.Models.Input;
/// <summary>
///     Stores a ordering step options for the <see cref="ViewOutput{TMigrationSet}"/>
///     builder, indicating how the current ordering step should behave.
/// </summary>
public class ViewOrdering {
    /// <summary>
    ///     Property name to apply this ordering action.
    /// </summary>
    public required string Property;

    /// <summary>
    ///     Order calculation to apply.
    /// </summary>
    public required ViewOrderings Ordering;
}

/// <summary>
///     Store the available ways to order the instructions of ordering.
/// </summary>
public enum ViewOrderings {
    /// <summary>
    ///     Up to Down.
    /// </summary>
    Ascending,
    /// <summary>
    ///     Down to Up.
    /// </summary>
    Descending,
}