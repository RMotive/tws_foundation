
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using CSM_Security.Depots;
using CSM_Security.Entities;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services.Security;
public class ContactsService
    : IContactsService {
    private readonly ContactsDepot Contacts;
    public ContactsService(ContactsDepot contacts) {
        Contacts = contacts;
    }
    public async Task<SetBatchOut<Contact>> Create(Contact[] Contact) {
        return await Contacts.Create(Contact);
    }

    public async Task<SetViewOut<Contact>> View(SetViewOptions<Contact> Options) {
        return await Contacts.View(Options);
    }
}
