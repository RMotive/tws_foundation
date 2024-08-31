using CSM_Foundation.Core.Utils;
using CSM_Foundation.Databases.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="TruckDepot"/>.
/// </summary>
public class Q_TruckDepot
    : BQ_MigrationDepot<Truck, TruckDepot, TWSBusinessDatabase> {
    public Q_TruckDepot()
        : base(nameof(Truck.Id)) {
    }

    protected override Truck MockFactory() {

        return new() {
            Status = 1,
            Manufacturer = 1,
            Motor = RandomUtils.String(16),
            Common = 1,
        };
    }
}
