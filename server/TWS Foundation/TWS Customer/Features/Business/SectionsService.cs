using CSM_Foundation.Customer;

using TWS_Business.Depots.Directories;
using TWS_Business.Entities;

namespace TWS_Customer.Features.Business;

/// <summary>
///     [Interface] for <see cref="Section"/> based [Service] implementations.
/// </summary>
public interface ISectionsService
    : IService<Section> {
}

/// <summary>
///     [Service] for <see cref="Section"/> based operations.
/// </summary>
public class SectionsService
    : BService<Section, ISectionsDepot>, ISectionsService {

    /// <summary>
    ///     Creates a new instance of <see cref="SectionsService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Section"/> based [Depot] handler to be used.
    /// </param>
    public SectionsService(ISectionsDepot Depot) : base(Depot) { }
}
