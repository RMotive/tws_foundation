using CSM_Foundation.Database.Entity;

using CSM_Security.Entities;

namespace CSM_Security.Depots;

/// <summary>
///     [Interface] for [ContactsDepot] implementations.
/// </summary>
public interface IContactsDepot
    : IDepot<Contact> {
}

/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Contact"/> dataDatabases entity mirror.
/// </summary>
public class ContactsDepot
     : BDepot<Database, Contact>, IContactsDepot {

    /// <summary>
    ///     Creates a new <see cref="ContactsDepot"/> instance.
    /// </summary>
    /// <param name="Database">
    ///     Database handler to be used.
    /// </param>
    /// <param name="Disposer">
    ///     Data disposition manager to be used.
    /// </param>
    public ContactsDepot(Database Database, IDisposer? Disposer = null) : base(Database, Disposer) { }
}
