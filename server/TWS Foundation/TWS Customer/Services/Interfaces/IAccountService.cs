using CSM_Foundation.Databases.Models.Options;
using CSM_Foundation.Databases.Models.Out;

using TWS_Security.Sets;

namespace TWS_Customer.Services.Interfaces;
public interface IAccountsService {

    Task<SetViewOut<Account>> View(SetViewOptions options);

}
