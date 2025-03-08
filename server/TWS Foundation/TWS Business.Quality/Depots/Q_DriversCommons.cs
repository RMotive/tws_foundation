using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality;

using TWS_Business.Depots;
using TWS_Business.Entities;
using TWS_Business.Entities.Drivers;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="DriversCommonsDepot"/>.
/// </summary>
public class Q_DriversCommons
    : BQ_Depot<Driver_Common, DriversCommonsDepot, Database> {
    public Q_DriversCommons()
        : base(nameof(Driver_Common.Id)) {
    }

    protected override Driver_Common MockFactory(string RandomSeed) {

        return new() {
            License = RandomUtils.String(12),
            Status = new Status {
                Id = 1
            }
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Driver_Common Mock) {
        return (nameof(Driver_Common.License), Mock.License);
    }
}