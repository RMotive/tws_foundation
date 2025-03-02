using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Exceptions;
using CSM_Foundation.Database.Models.Out;

using CSM_Security.Entities.Permits;
using CSM_Security.Entities.Profiles;

using Microsoft.EntityFrameworkCore;


namespace CSM_Security.Entities.Accounts;
/// <summary>
///     Implements a new depot to handle <see cref="Account"/> entity
///     transactions. 
/// </summary>
public class AccountsDepot
    : BDepot<Database, Account>
    , IAccountsDepot {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Account"/>.
    /// </summary>
    public AccountsDepot(Database Databases, IDisposer? Disposer = null)
        : base(Databases, Disposer) {
    }
    /// <summary>
    ///     Generates a new depot handler for <see cref="Account"/>.
    /// </summary>
    public AccountsDepot()
        : base(new(), null) {
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="AccountPointer"></param>
    /// <returns></returns>
    public async Task<Permit[]> GetPermits(long AccountPointer) {
        SetBatchOut<Account> accountReadOut = await Read(
                ReadBehaviors.First,
                (record) => record.Id == AccountPointer,
                (query) => {
                    return query
                        .Include(a => a.Permits)
                        .Include(a => a.Profiles)
                            .ThenInclude(p => p.Permits);
                }
            );

        if (accountReadOut.Failed) {
            throw new XRecord(typeof(Account), $"Account.Id = {AccountPointer}", XRecordSituations.Unfound);
        }
        Account account = accountReadOut.Successes[0];
        Permit[] directPermits = [.. account.Permits];
        Profile[] profiles = [.. account.Profiles];

        Permit[] totalPermits = [.. directPermits];
        foreach (Profile profile in profiles) {

            Permit[] profilePermits = [.. profile.Permits];

            foreach (Permit profilePermit in profilePermits) {
                if (totalPermits.Any(i => i.Id == profilePermit.Id))
                    continue;

                totalPermits = [.. totalPermits, profilePermit];
            }
        }

        return totalPermits;
    }
}
