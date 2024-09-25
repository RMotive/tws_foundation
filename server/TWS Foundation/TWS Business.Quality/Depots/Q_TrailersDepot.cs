using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="TrailersDepot"/>.
/// </summary>
public class Q_TrailersDepot
    : BQ_Depot<Trailer, TrailersDepot, TWSBusinessDatabase> {
    public Q_TrailersDepot()
        : base(nameof(Trailer.Id)) {
    }

    protected override Trailer MockFactory(string RandomSeed) {

        return new() {
            Manufacturer = 1,
            Common = 0,
            Status = 1,
            Carrier = 1,
            TrailerCommonNavigation = new() {
                Timestamp = DateTime.Now,
                Status = 1,
                Economic = RandomUtils.String(16),
            }

        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Trailer Mock) {
        return null;
    }
}