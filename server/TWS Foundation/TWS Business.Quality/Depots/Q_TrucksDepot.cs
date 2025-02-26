using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality;

using TWS_Business.Depots;
using TWS_Business.Entities;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="TruckDepot"/>.
/// </summary>
public class Q_TruckDepot
    : BQ_Depot<Truck, TruckDepot, BusinessDatabase> {
    public Q_TruckDepot()
        : base(nameof(Truck.Id)) {
    }

    protected override Truck MockFactory(string RandomSeed) {
        DateOnly date = DateOnly.FromDateTime(DateTime.Now);

        return new() {
            VIN = RandomUtils.String(17),
            Motor = RandomUtils.String(16),
            Common = new() {
                Timestamp = DateTime.Now,
                Status = new Status {
                    Id = 1,
                },
                Economic = RandomUtils.String(16),
            },
            Model = new() {
                Status = 1,
                Name = RandomUtils.String(32),
                Year = date,
                Manufacturer = 0,
                ManufacturerNavigation = new() {
                    Name = RandomUtils.String(32),
                }
            },
            Carrier =  new() {
                Name = RandomUtils.String(10),
                Status = new Status {
                    Id = 1,
                },
                Approach = new() {
                    Status = 1,
                    Email = RandomUtils.String(30)
                },
                Address = new() {
                    Country = "USA"
                }
            }
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Truck Mock) {
        return (nameof(Truck.Motor), Mock.Motor);
    }
}
