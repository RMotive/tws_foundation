using CSM_Foundation.Database.Entity;

using CSM_Security.Entities;

namespace CSM_Security.Depots;

/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Contact"/> dataDatabases entity mirror.
/// </summary>
public class ContactsDepot
     : BDepot<Database, Contact> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Contact"/>.
    /// </summary>
    public ContactsDepot(IDisposer? Disposer = null) : base(new(), Disposer) { }

    public ContactsDepot()
        : base(new(), null) {

    }

}
