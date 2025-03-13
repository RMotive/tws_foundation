
using CSM_Foundation.Customer;

using CSM_Security.Depots;
using CSM_Security.Entities;

namespace TWS_Customer.Features.Security;

/// <summary>
///     [Interface] for <see cref="Contact"/> based [Service] implementations.
/// </summary>
public interface IContactsService
    : IService<Contact> {

}

/// <summary>
///    [Service] implementation for <see cref="Contact"/> based operations.
/// </summary>
public class ContactsService
    : BService<Contact, IContactsDepot>, IContactsService {

    /// <summary>
    ///     Creates a new <see cref="ContactsService"/> instance.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Contact"/> based [Depot] handler to be used.
    /// </param>
    public ContactsService(IContactsDepot Depot) : base(Depot) { }
}
