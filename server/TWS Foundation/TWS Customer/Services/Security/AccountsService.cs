using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using CSM_Security.Entities.Accounts;

using Microsoft.EntityFrameworkCore;

using TWS_Customer.Services.Interfaces;

namespace TWS_Customer.Services.Security;
/// <summary>
/// 
/// </summary>
public class AccountsService
    : IAccountsService {
    /// <summary>
    /// 
    /// </summary>
    private readonly IAccountsDepot AccountsDepot;
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Solutions"></param>
    public AccountsService(IAccountsDepot Accounts) {
        AccountsDepot = Accounts;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Options"></param>
    /// <returns></returns>
    public async Task<SetViewOut<Account>> View(SetViewOptions<Account> Options) {

        static IQueryable<Account> include(IQueryable<Account> query) {
            return query.Include(t => t.Contact);
        }

        return await AccountsDepot.View(Options, include);
    }
}
