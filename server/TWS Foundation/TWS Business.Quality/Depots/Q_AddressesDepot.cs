using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="AddressesDepot"/>.
/// </summary>
public class Q_AddressesDepot
    : BQ_Depot<Address, AddressesDepot, TWSBusinessDatabase> {
    public Q_AddressesDepot()
        : base(nameof(Address.Id)) {
    }

    protected override Address MockFactory(string RandomSeed) {

        return new() {
            Country = "USA"
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Address Mock)
    => (nameof(Address.Street), Mock.Street);
}