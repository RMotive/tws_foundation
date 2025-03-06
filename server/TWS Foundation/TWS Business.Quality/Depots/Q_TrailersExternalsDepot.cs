using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality;

using TWS_Business.Entities;
using TWS_Business.Entities.Trailers;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="TrailersExternalsDepot"/>.
/// </summary>
public class Q_TrailersExternalsDepot
    : BQ_Depot<TrailerExternal, TrailersExternalsDepot, BusinessDatabase> {
    public Q_TrailersExternalsDepot()
        : base(nameof(TrailerExternal.Id)) {
    }

    protected override TrailerExternal MockFactory(string RandomSeed) {

        return new() {
            Carrier = "CarrierHistory test",
            MxPlate = "12345678",
            Common = new() {
                Status = new Status { Id = 1 },
                Economic = RandomUtils.String(16),
            }
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(TrailerExternal Mock) {
        return (nameof(TrailerExternal.Carrier), Mock.Carrier);
    }
}