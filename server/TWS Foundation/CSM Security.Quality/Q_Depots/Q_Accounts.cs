using System.Text;

using CSM_Security.Depots;
using CSM_Security.Entities;

namespace CSM_Security.Quality.Q_Depots;

public class Q_Accounts
    : BQ_Security<Account, AccountsDepot> {

    protected override Account EntityFactory(string Entropy) {
        return new Account {
            User = Entropy,
            Password = Encoding.UTF8.GetBytes(Entropy),
            Contact = new Contact {
                Name = Entropy,
                Lastname = Entropy,
                Phone = Entropy[..12],
                EMail = $"{Entropy}@q.com"
            }
        };
    }
}
