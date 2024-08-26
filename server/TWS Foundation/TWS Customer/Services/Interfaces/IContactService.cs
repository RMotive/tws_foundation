using CSM_Foundation.Databases.Models.Out;

using TWS_Security.Sets;

namespace TWS_Customer.Services.Interfaces;
public interface IContactService {
    Task<DatabasesTransactionOut<Contact>> Create(Contact[] contact);
}
