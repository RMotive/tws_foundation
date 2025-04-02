using System.Text;

using CSM_Foundation.Customer.Quality;

using CSM_Security.Depots;
using CSM_Security.Entities;

using TWS_Customer.Features.Security;
using TWS_Customer.Managers.Session;
using TWS_Customer.Quality.Factories;
using TWS_Customer.Services.Records;

namespace TWS_Customer.Quality.Q_Features.Q_Security;

/// <summary>
///     
/// </summary>
public class Q_SecurityService
    : BQ_Service<ISecurityService> {

    readonly SessionManager _sessionManager = new();

    public Q_SecurityService()
        : base(
                [
                    DatabaseFactories.SecurityDatabaseFactory,
                ]
            ) {

    }

    #region [BQ_Service] implementations
    protected override ISecurityService ServiceFactory() {
        CSM_Security.Database securityDatabase = DatabaseFactories.SecurityDatabaseFactory();

        IAccountsDepot accountsDepot = new AccountsDepot(securityDatabase, Disposer);

        return new SecurityService(accountsDepot, _sessionManager);
    }

    #endregion

    #region Private Methods/Functions

    AuthenticationInput GenerateAccount(bool isWildcard = false) {
        Account accountEntity = RunEntityFactory(
                (string Entropy) => {
                    return new Account {
                        User = Entropy,
                        Wildcard = isWildcard,
                        Password = Encoding.UTF8.GetBytes(Entropy),
                        Contact = new Contact {
                            Name = Entropy,
                            Lastname = Entropy,
                            Phone = Entropy,
                            EMail = Entropy
                        },
                    };
                }
            );

        accountEntity = Store(accountEntity);

        return new AuthenticationInput {
            Identity = accountEntity.User,
            Password = accountEntity.Password,
            Sign = "TWSF"
        };
    }

    #endregion


    [Fact(DisplayName = "[Authenticate]: Wildcard authentication")]
    public async Task Authenticate() {

        AuthenticationInput input = GenerateAccount(true);

        ServerSession serverSession = await _service.Authenticate(input);

        Assert.Equal(serverSession.Identity, input.Identity);
        Assert.NotEmpty(serverSession.Token.ToString());
    }
}
