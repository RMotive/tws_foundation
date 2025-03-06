using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality;

using TWS_Business.Depots;
using TWS_Business.Entities;
using TWS_Business.Entities.Trucks;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="YardLogsDepot"/>.
/// </summary>
public class Q_YardLogsDepot
    : BQ_Depot<YardLog, YardLogsDepot, Database> {
    public Q_YardLogsDepot()
        : base(nameof(YardLog.Id)) {
    }

    protected override YardLog MockFactory(string RandomSeed) {

        return new() {
            Entry = false,
            LoadType = new LoadType {
                Id = 1,
            },
            Timestamp = DateTime.Now,
            Guard = new TWS_Business.Entities.Employees.Employee {
                Id = 1,
            },
            FromTo = RandomUtils.String(30),
            Truck = new Truck_Common {
                Timestamp = DateTime.UtcNow,
                Economic = RandomUtils.String(16),
                Status = new Status {
                    Id = 1,
                },
                External = new TruckExternal {
                    MxPlate = "12345678",
                    Carrier = "truck carrier qlty"
                }
            }
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(YardLog Mock) {
        return null;
    }
}