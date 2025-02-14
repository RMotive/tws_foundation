using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Interfaces;

using TWS_Business.Entities;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="UsdotH"/> dataDatabases entity mirror.
/// </summary>
public class UsdotHDepot : BDepot<BusinessDatabase, UsdotH> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="UsdotH"/>.
    /// </summary>
    public UsdotHDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public UsdotHDepot() : base(new(), null) {
    }
}
