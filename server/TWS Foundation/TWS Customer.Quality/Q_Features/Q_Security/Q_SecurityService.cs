using System.Text;

using CSM_Foundation.Core.Utils;

using CSM_Security.Depots;
using CSM_Security.Entities;

using Microsoft.AspNetCore.Http;

using TWS_Customer.Features.Security;
using TWS_Customer.Managers.Auth;
using TWS_Customer.Managers.Auth;
using TWS_Customer.Services.Records;

namespace TWS_Customer.Quality.Q_Features.Q_Security;

/// <summary>
///     
/// </summary>
public class Q_SecurityService
    : BQ_ServicesCustomer<ISecurityService> {
    public Q_SecurityService() {

    }

    #region [BQ_Service] implementations
    protected override ISecurityService ServiceFactory() {
        CSM_Security.Database securityDatabase = SecurityDatabaseFactory();

        IAccountsDepot accountsDepot = new AccountsDepot(securityDatabase, Disposer);
        IAuthManager authManager = new AuthManager(
                new HttpContextAccessor {
                    HttpContext = new DefaultHttpContext(),
                }
            );

        return new SecurityService(accountsDepot, authManager, new HttpContextAccessor());
    }

    #endregion

    #region Private Methods/Functions

    AuthInput GenerateAccount(bool isWildcard = false) {
        string entropy = RandomUtils.String(16);

        Contact contactEntity = Store(
                new Contact {
                    Name = entropy,
                    Lastname = entropy,
                    Phone = entropy[..14],
                    EMail = entropy
                }
            );

        Account accountEntity = Store(
                new Account {
                    User = entropy,
                    Wildcard = isWildcard,
                    Password = Encoding.UTF8.GetBytes(entropy),
                    Contact = contactEntity
                }
            );

        return new AuthInput {
            Identity = accountEntity.User,
            Password = accountEntity.Password,
            Sign = "TWSF"
        };
    }

    #endregion
}
