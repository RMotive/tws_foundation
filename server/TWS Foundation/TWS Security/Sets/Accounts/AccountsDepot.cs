using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Enumerators;
using CSM_Foundation.Database.Exceptions;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

namespace TWS_Security.Sets.Accounts;
/// <summary>
///     Implements a new depot to handle <see cref="Account"/> entity
///     transactions. 
/// </summary>
public class AccountsDepot
    : BDepot<TWSSecurityDatabase, Account>
    , IAccountsDepot {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Account"/>.
    /// </summary>
    public AccountsDepot(TWSSecurityDatabase Databases, IDisposer? Disposer = null)
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
    public async Task<Permit[]> GetPermits(int AccountPointer) {
        SetBatchOut<Account> accountReadOut = await Read(
                (Account record) => record.Id == AccountPointer,
                SetReadBehaviors.First,
                (IQueryable<Account> query) => {
                    query
                        .Include(i => i.Permits);
                    query
                        .Include(i => i.Profiles)
                        .ThenInclude(i => i.Permits);
                    return query;
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
