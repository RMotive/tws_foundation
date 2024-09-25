using System.ComponentModel.DataAnnotations;

using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="TruckDepot"/>.
/// </summary>
public class Q_TruckDepot
    : BQ_Depot<Truck, TruckDepot, TWSBusinessDatabase> {
    public Q_TruckDepot()
        : base(nameof(Truck.Id)) {
    }

    protected override Truck MockFactory(string RandomSeed) {

        return new() {
            Status = 1,
            Manufacturer = 1,
            Vin = RandomUtils.String(17),
            Motor = RandomUtils.String(16),
            Common = 0,
            TruckCommonNavigation = new() {
                Timestamp = DateTime.Now,
                Status = 1,
                Economic = RandomUtils.String(16),
            },
            Carrier = 1
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Truck Mock) {
        return (nameof(Truck.Motor), Mock.Motor);
    }
}
