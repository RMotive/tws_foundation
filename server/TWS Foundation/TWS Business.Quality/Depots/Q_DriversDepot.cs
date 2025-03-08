using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality;

using TWS_Business.Depots;
using TWS_Business.Entities;
using TWS_Business.Entities.Drivers;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="DriversDepot"/>.
/// </summary>
public class Q_DriversDepot
    : BQ_Depot<Driver, DriversDepot, Database> {
    public Q_DriversDepot()
        : base(nameof(Driver.Id)) {
    }

    protected override Driver MockFactory(string RandomSeed) {

        return new() {
            Employee = new TWS_Business.Entities.Employees.Employee {
                Id = 1,
            },
            DriverType = RandomUtils.String(12),
            Common = new() {
                Timestamp = DateTime.Now,
                Status = new Status {
                    Id = 1
                },
                License = RandomUtils.String(12)
            }
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Driver Mock) {
        return null;
    }
}