using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Models.Out;

using CSM_Security.Entities;

using Microsoft.EntityFrameworkCore;

using TWS_Customer.Managers.Configuration;
using TWS_Customer.Managers.Session;
using TWS_Customer.Services.Exceptions;
using TWS_Customer.Services.Interfaces;
using TWS_Customer.Services.Records;

namespace TWS_Customer.Services.Security;
public class SecurityService
    : ISecurityService {
    private readonly ConfigurationManager Configurations = ConfigurationManager.Manager;
    private readonly SessionManager SessionManager;
    private readonly IAccountsDepot Accounts;

    public SecurityService(IAccountsDepot Accounts, SessionManager SessionManager) {
        this.Accounts = Accounts;
        this.SessionManager = SessionManager;
    }

    public async Task<Session> Authenticate(Credentials Credentials) {

        static IQueryable<Account> Include(IQueryable<Account> query) {
            return query.Include(c => c.Contact);
        }

        SetBatchOut<Account> result = await Accounts.Read(ReadBehaviors.First, i => i.User == Credentials.Identity, Include);
        if (result.Failed) {
            throw new XSetOperation<Account>(result.Failures);
        }

        if (result.QTransactions == 0) {
            throw new XAuthenticate(XAuthenticateSituation.IDENTITY_UNFOUND);
        }

        Account account = result.Successes[0];
        if (!account.Password.SequenceEqual(Credentials.Password)) {
            throw new XAuthenticate(XAuthenticateSituation.WRONG_PASSWORD);
        }

        Permit[] permits = await Accounts.GetPermits(account.Id);
        Guid token = SessionManager.Authorize(Credentials);


        Session? session = SessionManager.Get(token, account, permits, true)
            ?? throw new XAuthenticate(XAuthenticateSituation.SESSION_UNFOUND);
        if (account.Wildcard) {
            return session;
        }

        SolutionConfiguration solutionConfiguration = Configurations.GetSolution(Credentials.Sign);

        if (!solutionConfiguration.Enabled) {
            throw new XAuthenticate(XAuthenticateSituation.SOLUTION_DISABLED);
        }

        return session.Permits.Any(i => i.Reference == solutionConfiguration.Login)
            ? session
            : throw new XAuthenticate(XAuthenticateSituation.UNAUTHORIZED_SOLUTION);
    }
}
