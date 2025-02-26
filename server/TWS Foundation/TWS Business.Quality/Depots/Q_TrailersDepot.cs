using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality;

using TWS_Business.Depots;
using TWS_Business.Entities;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="TrailersDepot"/>.
/// </summary>
public class Q_TrailersDepot
    : BQ_Depot<Trailer, TrailersDepot, BusinessDatabase> {
    public Q_TrailersDepot()
        : base(nameof(Trailer.Id)) {
    }

    protected override Trailer MockFactory(string RandomSeed) {

        return new() {
            Status = new Status {
                Id = 1,
            },
            Common = new() {
                Status = 1,
                Timestamp = DateTime.Now,
                Economic = RandomUtils.String(16),
            },
            Carrier = new() {
                Status = new Status {
                    Id = 1,
                },
                Name = RandomUtils.String(10),
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

    protected override (string Property, string? Value)? FactorizeProperty(Trailer Mock) {
        return null;
    }
}