using CSM_Foundation.Database.Entity.Models.Out;

namespace CSM_Foundation.Database.Entity.Models;
/// <summary>
///     Stores a ordering step options for the <see cref="SetViewOutput{TMigrationSet}"/>
///     builder, indicating how the current ordering step should behave.
/// </summary>
public class SetViewOrderOptions {
    /// <summary>
    ///     Property name to apply this ordering action.
    /// </summary>
    public required string Property;
    /// <summary>
    ///     Order calculation to apply.
    /// </summary>
    public required SetViewOrders Order;
}

/// <summary>
///     Store the available ways to order the instructions of ordering.
/// </summary>
public enum SetViewOrders {
    /// <summary>
    ///     Up to Down.
    /// </summary>
    Ascending,
    /// <summary>
    ///     Down to Up.
    /// </summary>
    Descending,
}