using CSM_Foundation.Core.Utils;
using CSM_Foundation.Databases.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="DriversDepot"/>.
/// </summary>
public class Q_DriversDepot
    : BQ_MigrationDepot<Driver, DriversDepot, TWSBusinessDatabase> {
    public Q_DriversDepot()
        : base(nameof(Driver.Id)) {
    }

    protected override Driver MockFactory() {

        return new() {
           Status = 1,
           Employee = 1,
           DriverType = RandomUtils.String(12),
           Common = 1
        };
    }
}