using System.Text;

using CSM_Foundation.Database.Quality.Bases;

using TWS_Security.Depots.Accounts;
using TWS_Security.Sets;

namespace TWS_Security.Quality.Depots;

/// <summary>
///     Qualifies the <see cref="AccountsDepot"/>.
/// </summary>
public class Q_AccountsDepot
    : BQ_Depot<Account, AccountsDepot, TWSSecurityDatabase> {
    public Q_AccountsDepot()
        : base(nameof(Account.Id)) {
    }

    protected override Account MockFactory(string RandomSeed) {
        return new() {
            User = " user depot" + RandomSeed,
            Password = Encoding.UTF8.GetBytes(RandomSeed),
            Wildcard = false,
            Contact = 0,
            ContactNavigation = new() {
                Name = "nameDepot" + RandomSeed,
                Lastname = "lastnamedepot" + RandomSeed,
                Email = "email@depot." + RandomSeed,
                Phone =  RandomSeed[..14],
            }
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Account Mock) {
        return (nameof(Account.User), Mock.User);
    }
}
