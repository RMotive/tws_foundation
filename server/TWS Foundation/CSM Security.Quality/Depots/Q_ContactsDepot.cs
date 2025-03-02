
using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality;

using CSM_Security.Entities.Contacts;

namespace CSM_Security.Quality.Depots;

/// <summary>
///     Qualifies the <see cref="ContactsDepot"/>.
/// </summary>
public class Q_ContactsDepot
    : BQ_Depot<Contact, ContactsDepot, Database> {
    public Q_ContactsDepot()
        : base(nameof(Contact.Name)) {
    }

    protected override Contact MockFactory(string RandomSeed) {
        return new() {
            Name = RandomUtils.String(50),
            Lastname = RandomUtils.String(50),
            Email = RandomUtils.String(30),
            Phone = RandomUtils.String(14),
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Contact Mock) {
        return (nameof(Contact.Name), Mock.Name);
    }
}
