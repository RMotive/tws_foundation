using CSM_Security.Depots;
using CSM_Security.Entities;
using CSM_Security.Quality.Utils;

using TWS_Customer.Features;
using TWS_Customer.Features.Security;

namespace TWS_Customer.Quality.Q_Features.Q_Security;

/// <summary>
///     Quality tests class for <see cref="AccountsService"/> implementation.
/// </summary>
public class Q_AccountsService
    : BQ_Service<IAccountsService, Account> {

    /// <summary>
    ///     Creates a new instance.
    /// </summary>
    public Q_AccountsService() { }


    protected override Account DraftEntity(string entropy)
    => DraftUtils.Account();

    protected override AccountsService ServiceFactory() {
        CSM_Security.Database securityDatabase = BuildSecurityDb();

        IAccountsDepot accountsDepot = new AccountsDepot(securityDatabase, Disposer);

        return new AccountsService(accountsDepot);
    }

    [Fact(DisplayName = "[Get]: Throws exception cause user doesn't exist")]
    public async Task Get() {

        XRead<Account> exception = await Assert.ThrowsAsync<XRead<Account>>(
                async () => await service.Get(Guid.NewGuid().ToString())
            );

        Assert.Equal(XReadReasons.UNFOUND, exception.Reason);
    }

    [Fact(DisplayName = "[Get]: Correctly gets the Account object by user")]
    public async Task GetA() {
        Account accountSample = DraftUtils.Account();
        accountSample = Store(accountSample);

        Account fetchdAccount = await service.Get(accountSample.User);

        Assert.Equal(accountSample.Id, fetchdAccount.Id);
    }

    [Fact(DisplayName = "[GetPermits]: Correctly gets the effective permits the user has access to")]
    public async Task GetPermits() {

        //Permit enDirectPermit = new();
        //Permit disDirectPermit = new(
        //        enabled: false
        //    );
        //Permit enProfilePermit = SamplePermit();
        //Permit disProfilePermit = SamplePermit(
        //        enabled: false
        //    );

        //Profile profileSample = SampleProfile(
        //        [
        //            enProfilePermit,
        //            disProfilePermit,
        //        ]
        //    );

        //Account accountSample = DraftUtils.Account(
        //        new Account {
        //            Permits = [
        //                    enDirectPermit,
        //                    disDirectPermit,
        //                ],
        //            Profiles = [
        //                    profileSample,
        //                ]
        //        }
        //    );
        //accountSample = Store( accountSample );

        //Permit[] effectivePermits = await service.GetPermits(accountSample.Id);

        //Assert.NotEmpty(effectivePermits);
        //Assert.Equal(2, effectivePermits.Length);
        //Assert.All(
        //        effectivePermits,
        //        permit => {
        //            Assert.True(permit.Enabled);
        //            Assert.True(permit.Id == enDirectPermit.Id || permit.Id == enProfilePermit.Id);
        //        }
        //    );
    }
}
