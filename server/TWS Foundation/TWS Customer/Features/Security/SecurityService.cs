using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Entity.Models.Output;

using CSM_Security.Depots;
using CSM_Security.Entities;

using TWS_Customer.Managers.Configuration;
using TWS_Customer.Managers.Session;
using TWS_Customer.Services.Exceptions;
using TWS_Customer.Services.Records;

namespace TWS_Customer.Features.Security;

public interface ISecurityService {

    /// <summary>
    ///     Authenticates a given credentials subscribing the session into the current <see cref="SessionManager"/> context.
    /// </summary>
    /// <param name="Credentials">
    ///     Authentication credentials.
    /// </param>
    /// <returns>
    ///     The <see cref="Session"/> information referencing the given <see cref="Credentials"/> session.
    /// </returns>
    Task<Session> Authenticate(Credentials Credentials);
}

/// <summary>
///     [Service] implementation for [Security] operations.
/// </summary>
public class SecurityService
    : ISecurityService {

    /// <summary>
    ///     Current running environment configurations.
    /// </summary>
    readonly ConfigurationManager Configurations = ConfigurationManager.Manager;

    /// <summary>
    ///     Manager for session handling and context.
    /// </summary>
    readonly SessionManager SessionManager;

    /// <summary>
    ///     [Depot] handler for <see cref="Account"/> entity.
    /// </summary>
    readonly IAccountsDepot AccountsDepot;

    public SecurityService(IAccountsDepot accounts, SessionManager sessionManager) {
        AccountsDepot = accounts;
        SessionManager = sessionManager;
    }

    public async Task<Session> Authenticate(Credentials Credentials) {

        BatchOperationOutput<Account, Account> result = await AccountsDepot.Read(
                EntityBatchBehaviors.First,
                (account) => account.User == Credentials.Identity
            );
        if (result.Failed) {
            throw new XSetOperation<Account>(result.Failures);
        }

        if (result.OperationsCount == 0) {
            throw new XAuthenticate(XAuthenticateSituation.IDENTITY_UNFOUND);
        }

        Account account = result.Successes[0];
        if (!account.Password.SequenceEqual(Credentials.Password)) {
            throw new XAuthenticate(XAuthenticateSituation.WRONG_PASSWORD);
        }

        Permit[] permits = await AccountsDepot.GetPermits(account.Id);
        Guid token = SessionManager.Authorize(Credentials);


        Session? session = SessionManager.Get(token, account, permits, true)
            ?? throw new XAuthenticate(XAuthenticateSituation.SESSION_UNFOUND);
        if (account.Wildcard) {
            return session;
        }

        SolutionConfiguration solutionConfiguration = Configurations.GetSolution(Credentials.Sign);

        return !solutionConfiguration.Enabled
            ? throw new XAuthenticate(XAuthenticateSituation.SOLUTION_DISABLED)
            : session.Permits.Any(i => i.Reference == solutionConfiguration.Login)
            ? session
            : throw new XAuthenticate(XAuthenticateSituation.UNAUTHORIZED_SOLUTION);
    }
}
