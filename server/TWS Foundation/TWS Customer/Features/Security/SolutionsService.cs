using CSM_Foundation.Product;

using CSM_Security.Depots;
using CSM_Security.Entities;

namespace TWS_Customer.Features.Security;

/// <summary>
///     [Interface] for <see cref="Solution"/> based [Service] implementations.
/// </summary>
public interface ISolutionsService
    : IService<Solution> {
}

/// <summary>
///     [Service] implementation for <see cref="Solution"/> based operations.
/// </summary>
public class SolutionsService
    : BService<Solution, ISolutionsDepot>, ISolutionsService {

    /// <summary>
    ///     Creates a new <see cref="SolutionsService"/> instance.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Solution"/> based [Depot] handler to be used.
    /// </param>
    public SolutionsService(ISolutionsDepot Depot) : base(Depot) { }
}
