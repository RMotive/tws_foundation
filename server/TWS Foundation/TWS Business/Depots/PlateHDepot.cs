using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Interfaces;

using TWS_Business.Entities;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="PlatesHDepot"/> dataDatabases entity mirror.
/// </summary>
public class PlatesHDepot
: BDepot<BusinessDatabase, PlateH> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="PlatesHDepot"/>.
    /// </summary>
    public PlatesHDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public PlatesHDepot() : base(new(), null) {
    }
}
