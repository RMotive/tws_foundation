using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="TrucksExternalsDepot"/>.
/// </summary>
public class Q_TrucksExternalsDepot
    : BQ_Depot<TruckExternal, TrucksExternalsDepot, TWSBusinessDatabase> {
    public Q_TrucksExternalsDepot()
        : base(nameof(TruckExternal.Id)) {
    }

    protected override TruckExternal MockFactory(string RandomSeed) {

        return new() {
            Status = 1,
            Common = 0,
            TruckCommonNavigation = new() {
                Timestamp = DateTime.Now,
                Status = 1,
                Economic = RandomUtils.String(16),
            },
            MxPlate = "12345678",
            Carrier = "truck carrier qlty"
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(TruckExternal Mock) {
        return null;
    }
}