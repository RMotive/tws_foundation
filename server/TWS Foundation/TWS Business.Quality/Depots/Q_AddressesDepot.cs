using CSM_Foundation.Database.Quality;

using TWS_Business.Depots;
using TWS_Business.Entities;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="AddressesDepot"/>.
/// </summary>
public class Q_AddressesDepot
    : BQ_Depot<Address, AddressesDepot, Database> {
    public Q_AddressesDepot()
        : base() {
    }

    protected override Address EntityFactory(string Entropy) {
        return new() {
            Country = Entropy[..3],
        };
    }
}