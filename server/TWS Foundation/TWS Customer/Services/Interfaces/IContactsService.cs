using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Security.Sets.Contacts;

namespace TWS_Customer.Services.Interfaces;
public interface IContactsService {
    Task<SetBatchOut<Contact>> Create(Contact[] contact);

    Task<SetViewOut<Contact>> View(SetViewOptions<Contact> Options);
}
