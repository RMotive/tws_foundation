using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality;

using TWS_Business.Depots.Vehicules;
using TWS_Business.Entities;
using TWS_Business.Entities.Drivers;

namespace TWS_Business.Quality.Depots;

/// <summary>
///     Qualifies the <see cref="DriversCommonsDepot"/>.
/// </summary>
public class Q_DriversCommons
    : BQ_Depot<Driver_Common, Drivers_CommonsDepot, Database> {

    protected override Driver_Common EntityFactory(string Entropy) {
        return new() {
            License = RandomUtils.String(12),
            Status = new Status {
                Id = 1
            }
        };
    }
}