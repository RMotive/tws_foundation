using CSM_Foundation.Database.Entity;

using CSM_Security.Entities.Permits;

namespace CSM_Security.Entities.Accounts;
public interface IAccountsDepot 
    : IDepot<Account> {
    public Task<Permit[]> GetPermits(long Account);
}
