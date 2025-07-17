using CSM_Foundation.Database;
using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Entity.Depot.IDepot_Read;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

using CSM_Security.Entities;

using Microsoft.EntityFrameworkCore;


namespace CSM_Security.Depots;

/// <summary>
///     [Interface] for <see cref="Account"/> based [Depot] implementations.
/// </summary>
public interface IAccountsDepot
    : IDepot<Account> {

    /// <summary>
    ///     Calculates the effective permits from the given <paramref name="id"/> as an <see cref="Account"/>.
    /// </summary>
    /// <param name="id">
    ///     <see cref="IEntity.Id"/> pointer identifier for the <see cref="Account"/> to calculate its effective permits.
    /// </param>
    /// <returns>
    ///     Effective <see cref="Permit"/> collection for the given <see cref="Account"/>.
    /// </returns>
    Task<Permit[]> GetPermits(long id);
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

    public async Task<Permit[]> GetPermits(long id) {
        BatchOperationOutput<Account> readOutput = await Read(
                new QueryInput<Account, FilterQueryInput<Account>> {
                    Parameters = new FilterQueryInput<Account> {
                        Behavior = FilteringBehaviors.First,
                        Filter = (record) => record.Id == id,
                    },
                    PostProcessor = (query) => {
                        return query
                            .Include(a => a.Permits)
                            .Include(a => a.Profiles)
                                .ThenInclude(p => p.Permits);
                    },
                }
            );

        if (readOutput.Failed)
            throw readOutput.Failures[0].Exception;

        if (readOutput.SuccessesCount <= 0)
            throw new XDepot<Account>(XDepotSituations.Unfound);

        Account account = readOutput.Successes[0];

        List<Permit> effectivePermits = [];

        bool VerifyEffective(Permit permit) {
            return 
                permit.Enabled
                && permit.Feature.Enabled
                && permit.Action.Enabled
                && !effectivePermits.Any(ePermit => ePermit.Id == permit.Id);
        }


        foreach (Profile profile in account.Profiles) {
            foreach (Permit profilePermit in profile.Permits) {
                if (!VerifyEffective(profilePermit))
                    continue;

                effectivePermits.Add(profilePermit);
            }
        }

        foreach (Permit permit in account.Permits) {
            if (!VerifyEffective(permit))
                continue;

            effectivePermits.Add(permit);
        }

        return [..effectivePermits];
    }
}
