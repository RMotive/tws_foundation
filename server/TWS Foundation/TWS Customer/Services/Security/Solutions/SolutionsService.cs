using CSM_Foundation.Customer;
using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using CSM_Security.Entities;
using CSM_Security.Entities.Solutions;

namespace TWS_Customer.Services.Security.Solutions;

/// <summary>
///     [Abstract] base class for [SolutionService] implementations.
/// </summary>
public abstract class BSolutionsService
    : BService<Solution, ISolutionsDepot>, ISolutionsService {

    /// <summary>
    ///     Creates a new <see cref="BSolutionsService"/> instance.
    /// </summary>
    /// <param name="Depot">
    ///     Main [Entity] datasource [<see cref="IDepot{TEntity}"/>] depot handler.
    /// </param>
    /// <param name="Accumulate">
    ///     Default [Entity] dependencies accumulator when none given at operation level.
    /// </param>
    public BSolutionsService(ISolutionsDepot Depot, AccumulateDelegate<Solution>? Accumulate = null) 
        : base(Depot, Accumulate) {
    }
}

/// <summary>
///     Service implementation for <see cref="Solution"/> set, handling multi operations available for this entity.
/// </summary>
public class SolutionsService
    : BSolutionsService {
    /// <summary>
    ///     Creates a new <see cref="SolutionsService"/> instance. Service implementation for <see cref="Solution"/> set.
    /// </summary>
    /// <param name="Solutions"> 
    ///     Required Depot implementation to perform complex internal operations.
    /// </param>
    public SolutionsService(ISolutionsDepot Solutions)
        : base(Solutions) {
    }
}
