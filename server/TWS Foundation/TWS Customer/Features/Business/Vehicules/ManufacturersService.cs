using CSM_Foundation.Product;

using TWS_Business;
using TWS_Business.Depots.Vehicles;
using TWS_Business.Entities.Vehicules;

namespace TWS_Customer.Features.Business.Vehicules;

/// <summary>
///     [Interface] for <see cref="Manufacturer"/> based [Service] implementations.
/// </summary>
public interface IManufacturersService
    : IService<Manufacturer> {
}

/// <summary>
///     [Service] for <see cref="Manufacturer"/> based operations.
/// </summary>
public class ManufacturersService
    : BService<Manufacturer, ManufacturersDepot>, IManufacturersService {

    private readonly Database _db;

    /// <summary>
    ///     Creates a new instance of <see cref="ManufacturersService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Manufacturer"/> based [Depot] handler to be used.
    /// </param>
    public ManufacturersService(ManufacturersDepot Depot, Database Database) : base(Depot) {
        this._db = Database;
    }
}
