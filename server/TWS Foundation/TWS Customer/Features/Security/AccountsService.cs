using CSM_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Database_Core.Depots.Models;

using CSM_Foundation.Product;

using CSM_Security.Depots;
using CSM_Security.Entities;

using Microsoft.EntityFrameworkCore;

namespace TWS_Customer.Features.Security;

/// <summary>
///     [Interface] for <see cref="Account"/> based [Service] implementations.
/// </summary>
public interface IAccountsService
    : IService<Account> {

    /// <summary>
    ///     Reads the <see cref="Account"/> data from the given <paramref name="user"/>.
    /// </summary>
    /// <param name="user">
    ///     Account's user identifier.
    /// </param>
    /// <returns>
    ///     The <see cref="Account"/> data.
    /// </returns>
    Task<Account> Get(string user);

    /// <summary>
    ///     Reads the effective <see cref="Permit"/> collection the given <see cref="Account"/>'s <paramref name="id"/> have access to.
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

    private static QueryProcessor<Account> QueryProcessor => (sourceQuery) => {
        sourceQuery = sourceQuery
         .Include(e => e.Permits)
         .Include(e => e.Profiles);
        return sourceQuery;
    };

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

        if(queryOutput.Failed && queryOutput.Failures[0].Exception == null)
           throw new Exception("An error occurred, but no exception data is available.");

        if (queryOutput.Failed)
            throw queryOutput.Failures[0].Exception!;

        if (queryOutput.SuccessesCount <= 0)
            throw new XRead<Account>(XReadReasons.UNFOUND);

        return queryOutput.Successes[0];
    }

    public Task<Permit[]> GetPermits(long id) {
        return depot.GetPermits(id);
    }
    public async override Task<ViewOutput<Account>> View(QueryInput<Account, ViewInput<Account>> input) {
        input.PostProcessor = QueryProcessor;
        return await depot.View(input);
    }
}
