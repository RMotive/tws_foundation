
using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Customer.Services.Interfaces;

using TWS_Security.Depots;
using TWS_Security.Sets;

namespace TWS_Customer.Services.Administration;
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
