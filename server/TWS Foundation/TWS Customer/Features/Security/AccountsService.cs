using CSM_Database_Core.Core.Errors;
using CSM_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Database_Core.Depots.Models;

using CSM_Foundation.Product;

using CSM_Security;
using CSM_Security.Depots;
using CSM_Security.Entities;

using Microsoft.EntityFrameworkCore;

using TWS_Customer.Managers.Auth;
using TWS_Customer.Managers.Session;

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

    /// <summary>
    /// Retrieves the <see cref="Vendor"/> associated with the account. If the account has the wildcard property set to true, 
    /// it will return all the enabled vendors in the system.
    /// </summary>
    /// <param name="id">The identifier used to filter vendors.</param>
    /// <returns>A task representing the asynchronous operation, containing an array of Vendor objects.</returns>
    Task<ViewOutput<Vendor>> GetVendors();
}

/// <summary>
///     [Service] implementation for <see cref="Account"/> based operations.
/// </summary>
public class AccountsService
    : BService<Account, IAccountsDepot>, IAccountsService {

    readonly IAuthManager _authManager;

    readonly Database _database;


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
    public AccountsService(IAccountsDepot Depot, IAuthManager authManager, Database database)
        : base(Depot) {
        _authManager = authManager;
        _database = database;
    }

    public async Task<ViewOutput<Vendor>> GetVendors() {
        SessionData sessionData = await _authManager.Get();
        long accountId = sessionData.Account.Id;

        BatchOperationOutput<Account> readOutput = await depot.Read(
                new QueryInput<Account, FilterQueryInput<Account>> {
                    Parameters = new FilterQueryInput<Account> {
                        Behavior = FilteringBehaviors.First,
                        Filter = (record) => record.Id == accountId,
                    },
                    PostProcessor = (query) => {
                        return query
                            .Include(a => a.Vendors);
                    },
                }
            );

        if (readOutput.SuccessesCount <= 0)
            throw new DepotError<Account>(DepotErrorEvents.UNFOUND);


        if (readOutput.Failed && readOutput.Failures.Length != 0 && readOutput.Failures[0].Exception != null)
            throw readOutput.Failures[0].Exception!;



        if (readOutput.SuccessesCount > 0 && readOutput.Successes[0].Wildcard) {
            ViewOutput<Vendor> output = new() {
                Entities = [.. readOutput.Successes[0].Vendors],
                Pages = 1,
                Page = 1,
                Count = readOutput.Successes[0].Vendors.Count,
                Timestamp = DateTime.UtcNow,
            };

            return output;
        }

        Vendor[] vendors = [.. _database.Vendors.Where(v => v.IsEnabled)];

        ViewOutput<Vendor> wildCardOutput = new() {
            Entities = vendors,
            Pages = 1,
            Page = 1,
            Count = vendors.Length,
            Timestamp = DateTime.UtcNow,
        };

        return wildCardOutput;
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

        if (queryOutput.Failed && queryOutput.Failures[0].Exception == null)
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
