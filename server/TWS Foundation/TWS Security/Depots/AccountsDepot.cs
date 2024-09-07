using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;

using Microsoft.EntityFrameworkCore;

using TWS_Security.Depots.Interfaces;
using TWS_Security.Sets;

namespace TWS_Security.Depots;
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


    public async Task<Permit[]> GetPermits(int Account) {
        IQueryable<AccountPermit> accountPermits = Database.AccountsPermits
            .Where(i => i.Account == Account)
                .Include(i => i.PermitNavigation);

        IQueryable<Permit> permits = accountPermits
            .Select(i => i.PermitNavigation);

        Permit[] directPermits = await permits.ToArrayAsync();


        Profile[] accountProfiles = await Database.AccountsProfiles
            .Where(i => i.Account == Account)
                .Include(i => i.ProfileNavigation)
            .Select(i => i.ProfileNavigation)
            .ToArrayAsync();

        Permit[] totalPermits = [..directPermits];
        foreach (Profile accountProfile in accountProfiles) {

            Permit[] profilePermits = await Database.ProfilesPermits
                .Where(i => i.Profile == accountProfile.Id)
                    .Include(i => i.PermitNavigation)
                .Select(i => i.PermitNavigation)
                .ToArrayAsync();

            foreach (Permit profilePermit in profilePermits) {
                if(totalPermits.Any(i => i.Id == profilePermit.Id)) 
                    continue;

                totalPermits = [..totalPermits, profilePermit];
            }
        }

        return totalPermits;
    }
}
