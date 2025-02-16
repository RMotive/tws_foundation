using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using TWS_Security.Entities.Contacts;

namespace TWS_Customer.Services.Interfaces;
public interface IContactsService {
    Task<SetBatchOut<Contact>> Create(Contact[] contact);

    Task<SetViewOut<Contact>> View(SetViewOptions<Contact> Options);
}
