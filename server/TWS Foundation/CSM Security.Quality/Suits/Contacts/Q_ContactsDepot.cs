using CSM_Foundation.Database.Quality;

using CSM_Security.Depots;
using CSM_Security.Entities;

namespace CSM_Security.Quality.Suits.Contacts;

/// <summary>
///     Qualifies the <see cref="ContactsDepot"/>.
/// </summary>
public class Q_ContactsDepot
    : BQ_Depot<Contact, ContactsDepot, Database> {

    protected override Contact EntityFactory(string Entropy) {
        return new() {
            Name = Entropy[..8],
            Lastname = Entropy[9..],
            EMail = $"{Entropy[11..]}.com",
            Phone = Entropy[..14],
        };
    }
}
