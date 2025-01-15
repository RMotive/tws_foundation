using CSM_Foundation.Database.Enumerators;
using CSM_Foundation.Database.Models.Out;

using Microsoft.EntityFrameworkCore;

using TWS_Customer.Managers;
using TWS_Customer.Managers.Records;
using TWS_Customer.Services.Exceptions;
using TWS_Customer.Services.Interfaces;
using TWS_Customer.Services.Records;

using TWS_Security.Depots;
using TWS_Security.Sets;

namespace TWS_Customer.Services.SecurityServices;
public class SecurityService
    : ISecurityService {
    private readonly ConfigurationManager Configurations = ConfigurationManager.Manager;
    private readonly SessionManager SessionManager;
    private readonly AccountsDepot Accounts;

    public SecurityService(AccountsDepot Accounts, SessionManager SessionManager) {
        this.Accounts = Accounts;
        this.SessionManager = SessionManager;
    }

    public async Task<Session> Authenticate(Credentials Credentials) {

        static IQueryable<Account> Include(IQueryable<Account> query) {
            return query
                .Include(c => c.ContactNavigation)
                .Select(a => new Account() {
                    Id = a.Id,
                    User = a.User,
                    Password = a.Password,
                    Wildcard = a.Wildcard,
                    Contact = a.Contact,
                    ContactNavigation = new Contact() {
                        Id = a.ContactNavigation!.Id,
                        Name = a.ContactNavigation.Name,
                        Lastname = a.ContactNavigation.Lastname,
                        Email = a.ContactNavigation.Email,
                        Phone = a.ContactNavigation.Phone
                    },
                });
        }

        SetBatchOut<Account> result = await Accounts.Read(i => i.User == Credentials.Identity, SetReadBehaviors.First, Include);
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
