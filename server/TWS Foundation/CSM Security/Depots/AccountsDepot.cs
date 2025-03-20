using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Entity.Exceptions;

using CSM_Security.Entities;

using Microsoft.EntityFrameworkCore;


namespace CSM_Security.Depots;

/// <summary>
///     [Interface] for <see cref="Account"/> based [Depot] implementations.
/// </summary>
public interface IAccountsDepot
    : IDepot<Account> {

    /// <summary>
    ///     Calculates the effective permits from an Account.
    /// </summary>
    /// <param name="Acccount">
    ///     <see cref="IEntity.Id"/> pointer identifier for the <see cref="Account"/> to calculate its effective permits.
    /// </param>
    /// <returns>
    ///     Effective <see cref="Permit"/> collection for the given <see cref="Account"/>.
    /// </returns>
    Task<Permit[]> GetPermits(long Acccount);
}

/// <summary>
///     [Depot] implementation for <see cref="Account"/> based entity handler.
/// </summary>
public class AccountsDepot
    : BDepot<Database, Account>, IAccountsDepot {

    /// <summary>
    ///     Generates a new depot handler for <see cref="Account"/>.
    /// </summary>
    /// <param name="database">
    ///     Database handler to use.
    /// </param>
    /// <param name="Disposer">
    ///     Disposition manager handler to use.
    /// </param>
    public AccountsDepot(Database database, IDisposer? Disposer = null) : base(database, Disposer) { }

    public async Task<Permit[]> GetPermits(long Account) {
        EntityBatchOut<Account> accountReadOut = await Read(
                ReadBehaviors.First,
                (record) => record.Id == Account,
                (query) => {
                    return query
                        .Include(a => a.Permits)
                        .Include(a => a.Profiles)
                            .ThenInclude(p => p.Permits);
                }
            );

        if (accountReadOut.Failed) {
            throw new XDepot(typeof(Account), $"Account.Id = {Account}", XDepotSituations.Unfound);
        }
        Account account = accountReadOut.Successes[0];
        Permit[] directPermits = [.. account.Permits];
        Profile[] profiles = [.. account.Profiles];

        Permit[] totalPermits = [.. directPermits];
        foreach (Profile profile in profiles) {

            Permit[] profilePermits = [.. profile.Permits];

            foreach (Permit profilePermit in profilePermits) {
                if (totalPermits.Any(i => i.Id == profilePermit.Id)) {
                    continue;
                }

                totalPermits = [.. totalPermits, profilePermit];
            }
        }

        return totalPermits;
    }
}
