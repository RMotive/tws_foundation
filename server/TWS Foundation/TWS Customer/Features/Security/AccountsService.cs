using CSM_Foundation.Customer;
using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Entity.Depot.IDepot_Read;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

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
    ///     Account's user.
    /// </param>
    /// <returns>
    ///     The <see cref="Account"/> data.
    /// </returns>
    public Task<Account> Get(string user);
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
    public AccountsService(IAccountsDepot Depot) : base(Depot) { }


    public async Task<Account> Get(string user) {
        BatchOperationOutput<Account> queryOutput = await _depot.Read(
                new QueryInput<Account, FilterQueryInput<Account>> {
                    Parameters = new FilterQueryInput<Account> {
                        Behavior = FilteringBehaviors.First,
                        Filter = account => account.User == user
                    }
                }
            );

        if (queryOutput.SuccessesCount <= 0)
            throw new XRead<Account>(XReadReasons.UNFOUND);

        return queryOutput.Successes[0];
    }
}
