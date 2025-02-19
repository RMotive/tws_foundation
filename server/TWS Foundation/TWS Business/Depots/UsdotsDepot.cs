using CSM_Foundation.Database.Entity;

using TWS_Business.Entities;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="USDOT"/> dataDatabases entity mirror.
/// </summary>
public class UsdotsDepot : BDepot<BusinessDatabase, USDOT> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="USDOT"/>.
    /// </summary>
    public UsdotsDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public UsdotsDepot() : base(new(), null) {
    }
}
