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
            Common = 0,
            Status = 1,
            Carrier = 0,
            TrailerCommonNavigation = new() {
                Status = 1,
                Timestamp = DateTime.Now,
                Economic = RandomUtils.String(16),
            },
            CarrierNavigation = new() {
                Status = 1,
                Name = RandomUtils.String(10),
                Approach = 0,
                Address = 0,
                ApproachNavigation = new() {
                    Status = 1,
                    Email = RandomUtils.String(30)
                },
                AddressNavigation = new() {
                    Country = "USA"
                }
            }
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Trailer Mock) {
        return null;
    }
}