using CSM_Security.Depots;
using CSM_Security.Entities;

using TWS_Customer.Features;
using TWS_Customer.Features.Security;

namespace TWS_Customer.Quality.Q_Features.Q_Security;

/// <summary>
///     
/// </summary>
public class Q_AccountsService
    : BQ_ServicesCustomer<IAccountsService> {

    /// <summary>
    ///     
    /// </summary>
    public Q_AccountsService() { }

    protected override AccountsService ServiceFactory() {
        CSM_Security.Database securityDatabase = SecurityDatabaseFactory();

        IAccountsDepot accountsDepot = new AccountsDepot(securityDatabase, Disposer);

        return new AccountsService(accountsDepot);
    }

    [Fact(DisplayName = "GetByUser: Throws exception cause user doesn't exist")]
    public async Task Get() {

        XRead<Account> exception = await Assert.ThrowsAsync<XRead<Account>>(
                async () => await _service.Get(Guid.NewGuid().ToString())
            );

        Assert.Equal(XReadReasons.UNFOUND, exception.Reason);
    }

    [Fact(DisplayName = "GetByUser: Correctly gets the Account object by user")]
    public async Task GetA() {
        Account accountSample = SampleAccount();

        Account fetchdAccount = await _service.Get(accountSample.User);

        Assert.Equal(accountSample.Id, fetchdAccount.Id);
    }

    [Fact(DisplayName = "GetPermits: Correctly gets the effective permits the user has access to")]
    public async Task GetPermits() {

        Permit enDirectPermit = SamplePermit();
        Permit disDirectPermit = SamplePermit(
                enabled: false
            );
        Permit enProfilePermit = SamplePermit();
        Permit disProfilePermit = SamplePermit(
                enabled: false
            );

        Profile profileSample = SampleProfile(
                [
                    enProfilePermit,
                    disProfilePermit,
                ]
            );

        Account accountSample = SampleAccount(
                permits: [
                        enDirectPermit,
                        disDirectPermit,
                    ],
                profiles: [
                        profileSample,
                    ]
            );

        Permit[] effectivePermits = await _service.GetPermits(accountSample.Id);

        Assert.NotEmpty(effectivePermits);
        Assert.Equal(2, effectivePermits.Length);
        Assert.All(
                effectivePermits, 
                permit => {
                    Assert.True(permit.Enabled);
                    Assert.True( permit.Id == enDirectPermit.Id || permit.Id == enProfilePermit.Id );
                }
            );
    }
}
