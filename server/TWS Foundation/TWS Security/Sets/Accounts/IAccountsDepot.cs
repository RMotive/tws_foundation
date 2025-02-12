using CSM_Foundation.Database.Interfaces;

namespace TWS_Security.Sets.Accounts;
public interface IAccountsDepot 
    : IDepot<Account> {
    public Task<Permit[]> GetPermits(int Account);
}
