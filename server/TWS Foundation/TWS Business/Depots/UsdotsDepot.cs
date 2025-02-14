using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Interfaces;

using TWS_Business.Entities;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Usdot"/> dataDatabases entity mirror.
/// </summary>
public class UsdotsDepot : BDepot<BusinessDatabase, Usdot> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Usdot"/>.
    /// </summary>
    public UsdotsDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public UsdotsDepot() : base(new(), null) {
    }
}
