using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Usdot"/> dataDatabases entity mirror.
/// </summary>
public class UsdotsDepot : BDepot<TWSBusinessDatabase, Usdot> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Usdot"/>.
    /// </summary>
    public UsdotsDepot(TWSBusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public UsdotsDepot() : base(new(), null) {
    }
}
