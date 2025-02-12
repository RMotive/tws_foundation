using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Security.Sets.Accounts;

namespace TWS_Customer.Services.Interfaces;
public interface IAccountsService {

    Task<SetViewOut<Account>> View(SetViewOptions<Account> options);

}
