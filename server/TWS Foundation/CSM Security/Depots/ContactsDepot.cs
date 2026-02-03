using CSM_Database_Core.Depots.Abstractions.Bases;
using CSM_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Foundation_Core.Abstractions.Interfaces;

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
     : DepotBase<Database, Contact>, IContactsDepot {

    /// <summary>
    ///     Creates a new <see cref="ContactsDepot"/> instance.
    /// </summary>
    /// <param name="Database">
    ///     Database handler to be used.
    /// </param>
    /// <param name="Disposer">
    ///     Data disposition manager to be used.
    /// </param>
    public ContactsDepot(Database Database, IDisposer<IEntity>? Disposer = null) : base(Database, Disposer) { }
}
