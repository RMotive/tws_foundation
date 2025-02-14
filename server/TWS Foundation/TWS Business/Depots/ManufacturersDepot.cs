using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Interfaces;

using TWS_Business.Entities;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a new depot to handle <see cref="Manufacturer"/> entity
///     transactions. 
/// </summary>
public class ManufacturersDepot : BDepot<BusinessDatabase, Manufacturer> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Manufacturer"/>.
    /// </summary>
    public ManufacturersDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
        : base(Databases, Disposer) {
    }
    public ManufacturersDepot() : base(new(), null) {

    }
}
