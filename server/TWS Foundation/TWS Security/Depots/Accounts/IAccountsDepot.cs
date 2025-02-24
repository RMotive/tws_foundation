using CSM_Foundation.Database.Interfaces;

using TWS_Security.Sets;

namespace TWS_Security.Depots.Accounts;
public interface IAccountsDepot 
    : IDepot<Account> {
    public Task<Permit[]> GetPermits(int Account);
}
