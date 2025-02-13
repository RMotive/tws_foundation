using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Security.Sets.Accounts;

namespace TWS_Customer.Services.Interfaces;

/// <summary>
/// 
/// </summary>
public interface IAccountsService {

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Options"></param>
    /// <returns></returns>
    Task<SetViewOut<Account>> View(SetViewOptions<Account> Options);
}
