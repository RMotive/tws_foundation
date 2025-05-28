using System.Text;
using System.Text.Unicode;

using CSM_Foundation.Customer.Quality;
using CSM_Foundation.Database.Entity.Depot;

using CSM_Security.Depots;
using CSM_Security.Entities;

using TWS_Customer.Features;
using TWS_Customer.Features.Security;
using TWS_Customer.Quality.Factories;

namespace TWS_Customer.Quality.Q_Features.Q_Security;

/// <summary>
///     
/// </summary>
public class Q_AccountsService
    : BQ_Service<IAccountsService> {

    /// <summary>
    ///     
    /// </summary>
    public Q_AccountsService()
        : base(
                [
                    DatabaseFactories.SecurityDatabaseFactory,
                ]
            ) {
    }

    protected override AccountsService ServiceFactory() {
        CSM_Security.Database securityDatabase = DatabaseFactories.SecurityDatabaseFactory();

        IAccountsDepot accountsDepot = new AccountsDepot(securityDatabase, Disposer);

        return new AccountsService(accountsDepot);
    }



    [Fact(DisplayName = "GetByUser: Throws exception cause user doesn't exist")]
    public async Task Get() {

        XRead<Account> exception = await Assert.ThrowsAsync<XRead<Account>>(
                async () => await _service.Get(Guid.NewGuid().ToString())
            );

        Assert.Equal(XReadReasons.UNFOUND, exception.Situation);
    }

    [Fact(DisplayName = "GetByUser: Correctly gets the Account object by user")]
    public async Task GetA() {

        Contact contactSample = Store(
                new Contact {
                    Name = "testing_name",
                    Lastname = "testing_lastname",
                    Phone = Guid.NewGuid().ToString()[..10],
                    EMail = "testing@csm.com"
                }
            );

        Account accountSample = Store(
                new Account {
                    User = "testing_user",
                    Password = Encoding.UTF8.GetBytes("testing_password"),
                    Contact = contactSample,
                }
            );


        Account fetchdAccount = await _service.Get(accountSample.User);

        Assert.Equal(accountSample.Id, fetchdAccount.Id);
    }
}
