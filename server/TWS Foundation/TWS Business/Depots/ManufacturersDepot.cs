
using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a new depot to handle <see cref="Manufacturer"/> entity
///     transactions. 
/// </summary>
public class ManufacturersDepot : BDepot<TWSBusinessDatabase, Manufacturer> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Manufacturer"/>.
    /// </summary>
    public ManufacturersDepot(TWSBusinessDatabase Databases, IDisposer? Disposer = null)
        : base(Databases, Disposer) {
    }
    public ManufacturersDepot() : base(new(), null) {

    }
}
