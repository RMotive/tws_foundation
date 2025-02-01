
using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;

using TWS_Security.Sets;

namespace TWS_Security.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Profile"/> dataDatabases entity mirror.
/// </summary>
public class ProfilesDepot
     : BDepot<TWSSecurityDatabase, Profile> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Profile"/>.
    /// </summary>
    public ProfilesDepot(IDisposer? Disposer = null) : base(new(), Disposer) { }

    public ProfilesDepot()
        : base(new(), null) {

    }

}
