using CSM_Foundation.Databases.Bases;
using CSM_Foundation.Databases.Interfaces;

using TWS_Security.Sets;

namespace TWS_Security.Depots;

/// <summary>
///     Implements a <see cref="BDatabaseDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Contact"/> dataDatabases entity mirror.
/// </summary>
public class ContactsDepot
     : BDatabaseDepot<TWSSecurityDatabases, Contact> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Contact"/>.
    /// </summary>
    public ContactsDepot(IMigrationDisposer? Disposer = null) : base(new(), Disposer) { }

    public ContactsDepot()
        : base(new(), null) {

    }

}
