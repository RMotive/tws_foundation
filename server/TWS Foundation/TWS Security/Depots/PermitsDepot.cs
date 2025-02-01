
using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;

using TWS_Security.Sets;

namespace TWS_Security.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Permit"/> dataDatabases entity mirror.
/// </summary>
public class PermitsDepot
     : BDepot<TWSSecurityDatabase, Permit> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Permit"/>.
    /// </summary>
    public PermitsDepot(IDisposer? Disposer = null) : base(new(), Disposer) { }

    public PermitsDepot()
        : base(new(), null) {

    }

}
