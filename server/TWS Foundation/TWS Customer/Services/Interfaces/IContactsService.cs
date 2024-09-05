using CSM_Foundation.Database.Models.Out;

using TWS_Security.Sets;

namespace TWS_Customer.Services.Interfaces;
public interface IContactsService {
    Task<DatabasesTransactionOut<Contact>> Create(Contact[] contact);
}
