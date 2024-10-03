using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="TrailersExternalsDepot"/>.
/// </summary>
public class Q_TrailersExternalsDepot
    : BQ_Depot<TrailerExternal, TrailersExternalsDepot, TWSBusinessDatabase> {
    public Q_TrailersExternalsDepot()
        : base(nameof(TrailerExternal.Id)) {
    }

    protected override TrailerExternal MockFactory(string RandomSeed) {

        return new() {
            Common = 0,
            Status = 1,
            Carrier = "Carrier test",
            MxPlate = "12345678",
            TrailerCommonNavigation = new() {
                Status = 1,
                Economic = RandomUtils.String(16),
            }
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(TrailerExternal Mock) {
        return (nameof(TrailerExternal.Carrier), Mock.Carrier);
    }
}