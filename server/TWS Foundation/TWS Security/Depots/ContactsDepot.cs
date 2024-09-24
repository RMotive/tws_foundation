using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;

using TWS_Security.Sets;

namespace TWS_Security.Depots;

/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Contact"/> dataDatabases entity mirror.
/// </summary>
public class ContactsDepot
     : BDepot<TWSSecurityDatabase, Contact> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Contact"/>.
    /// </summary>
    public ContactsDepot(IDisposer? Disposer = null) : base(new(), Disposer) { }

    public ContactsDepot()
        : base(new(), null) {

    }

}
