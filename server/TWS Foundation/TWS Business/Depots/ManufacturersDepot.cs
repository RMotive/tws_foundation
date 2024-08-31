
using CSM_Foundation.Databases.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a new depot to handle <see cref="Manufacturer"/> entity
///     transactions. 
/// </summary>
public class ManufacturersDepot : BDatabaseDepot<TWSBusinessDatabase, Manufacturer> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Manufacturer"/>.
    /// </summary>
    public ManufacturersDepot() : base(new(), null) {

    }
}
