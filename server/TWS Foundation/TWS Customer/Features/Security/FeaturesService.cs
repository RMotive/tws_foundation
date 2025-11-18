using CSM_Foundation.Product;

using CSM_Security.Depots;
using CSM_Security.Entities;

namespace TWS_Customer.Features.Security;

/// <summary>
///     [Interface] for <see cref="Feature"/> based [Service] implementations.
/// </summary>
public interface IFeaturesService
    : IService<Feature> {
}

/// <summary>
///     [Service] implementation for <see cref="Feature"/> based operations.
/// </summary>
public class FeaturesService
    : BService<Feature, IFeaturesDepot>, IFeaturesService {

    /// <summary>
    ///     Creates a new <see cref="FeaturesService"/> instance.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Feature"/> based [Depot] handler to be used.
    /// </param>
    public FeaturesService(IFeaturesDepot Depot) : base(Depot) { }
}
