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

namespace TWS_Customer.Services;
public class SecurityService
    : ISecurityService {

    readonly ConfigurationManager Configurations = ConfigurationManager.Manager;
    readonly SessionsManager Sessions = SessionsManager.Manager; 

    readonly AccountsDepot Accounts;

    public SecurityService(AccountsDepot Accounts) {
        this.Accounts = Accounts;
    }

    public async Task<Session> Authenticate(Credentials Credentials) {

        static IQueryable<Account> include(IQueryable<Account> query) {
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

        SetBatchOut<Account> result = await Accounts.Read(i => i.User == Credentials.Identity, SetReadBehaviors.First, include);
        if (result.Failed) {
            throw new XMigrationTransaction<Account>(result.Failures);
        }

        if (result.QTransactions == 0) {
            throw new XAuthenticate(XAuthenticateSituation.Identity);
        }

        Account account = result.Successes[0];
        if (!account.Password.SequenceEqual(Credentials.Password)) {
            throw new XAuthenticate(XAuthenticateSituation.Password);
        }

        Permit[] permits = await Accounts.GetPermits(account.Id);
        Session session = Sessions.Subscribe(Credentials, account.Wildcard, permits, account.ContactNavigation!);

        if(session.Wildcard) 
            return session;

        SolutionConfiguration solutionConfiguration = Configurations.GetSolution(Credentials.Sign);

        if(!solutionConfiguration.Enabled) 
            throw new XAuthenticate(XAuthenticateSituation.SolutionDisabled);


        if(session.Permits.Any(i => i.Reference == solutionConfiguration.Login))
            return session;

        throw new XAuthenticate(XAuthenticateSituation.UnauthorizedSolution);
    }
}
