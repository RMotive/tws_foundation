using CSM_Foundation.Product;

using TWS_Business.Depots;
using TWS_Business.Entities;

namespace TWS_Customer.Features.Business;

/// <summary>
///     [Interface] for <see cref="Address"/> based [Service] implementations.
/// </summary>
public interface IAddressesService
    : IService<Address> {
}

/// <summary>
///     [Service] for <see cref="Address"/> based operations.
/// </summary>
public class AddressesService
    : BService<Address, IAddressesDepot>, IAddressesService {

    /// <summary>
    ///     Creates a new instance of <see cref="AddressesService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Address"/> based [Depot] handler to be used.
    /// </param>
    public AddressesService(IAddressesDepot Depot) : base(Depot) { }
}
