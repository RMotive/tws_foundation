using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using CSM_Security.Entities;

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
