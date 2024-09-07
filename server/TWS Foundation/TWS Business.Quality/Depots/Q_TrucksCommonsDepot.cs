using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="TrucksCommonsDepot"/>.
/// </summary>
public class Q_TrucksCommonsDepot
    : BQ_Depot<TruckCommon, TrucksCommonsDepot, TWSBusinessDatabase> {
    public Q_TrucksCommonsDepot()
        : base(nameof(TruckCommon.Id)) {
    }

    protected override TruckCommon MockFactory(string RandomSeed) {

        return new() {
            Status = 1,
            Vin = RandomUtils.String(17),
            Economic = RandomUtils.String(16),
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(TruckCommon Mock) {
        return (nameof(TruckCommon.Economic), Mock.Economic);
    }
}