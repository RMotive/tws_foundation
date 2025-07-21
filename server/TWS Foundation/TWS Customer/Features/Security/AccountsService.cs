using CSM_Foundation.Database.Entity.Depot.IDepot_Read;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;
using CSM_Foundation.Product;

using CSM_Security.Depots;
using CSM_Security.Entities;

namespace TWS_Customer.Features.Security;

/// <summary>
///     [Interface] for <see cref="Account"/> based [Service] implementations.
/// </summary>
public interface IAccountsService
    : IService<Account> {

    /// <summary>
    ///     Gets the <see cref="Account"/> data from the given <paramref name="user"/>.
    /// </summary>
    /// <param name="user">
    ///     Account's user identifier.
    /// </param>
    /// <returns>
    ///     The <see cref="Account"/> data.
    /// </returns>
    Task<Account> Get(string user);

    /// <summary>
    ///     Gets the effective <see cref="Permit"/> collection the given <see cref="Account"/>'s <paramref name="id"/> have access to.
    /// </summary>
    /// <param name="user">
    ///     Account's user identifier.
    /// </param>
    /// <returns>
    ///     Effective user permits collection.
    /// </returns>
    Task<Permit[]> GetPermits(long id);
}

/// <summary>
///     [Service] implementation for <see cref="Account"/> based operations.
/// </summary>
public class AccountsService
    : BService<Account, IAccountsDepot>, IAccountsService {

    /// <summary>
    ///     Creates a new <see cref="AccountsService"/> instance.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Account"/> based [Depot] handler to be used.
    /// </param>
    public AccountsService(IAccountsDepot Depot)
        : base(Depot) {
    }

    public async Task<Account> Get(string user) {
        BatchOperationOutput<Account> queryOutput = await depot.Read(
                new QueryInput<Account, FilterQueryInput<Account>> {
                    Parameters = new FilterQueryInput<Account> {
                        Behavior = FilteringBehaviors.First,
                        Filter = account => account.User == user
                    }
                }
            );

        if (queryOutput.Failed)
            throw queryOutput.Failures[0].Exception;

        if (queryOutput.SuccessesCount <= 0)
            throw new XRead<Account>(XReadReasons.UNFOUND);

        return queryOutput.Successes[0];
    }

    public Task<Permit[]> GetPermits(long id) {
        return depot.GetPermits(id);
    }
}
