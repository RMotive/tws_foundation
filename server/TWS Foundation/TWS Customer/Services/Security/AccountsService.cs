using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;
using TWS_Customer.Services.Records;

using TWS_Security.Depots.Accounts;
using TWS_Security.Sets;

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
            return query
            .Include(t => t.ContactNavigation)
            .Select(t => new Account() {
                Id = t.Id,
                User = t.User,
                Contact = t.Contact,
                ContactNavigation = t.ContactNavigation == null ? null : new Contact() {
                    Id = t.ContactNavigation.Id,
                    Name = t.ContactNavigation.Name,
                    Lastname = t.ContactNavigation.Lastname,
                    Email = t.ContactNavigation.Email,
                    Phone = t.ContactNavigation.Phone
                }
            });


        }

        return await AccountsDepot.View(Options, include);
    }
}
