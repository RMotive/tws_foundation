using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality;

using TWS_Business.Entities;
using TWS_Business.Entities.Trailers;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="TrailersDepot"/>.
/// </summary>
public class Q_TrailersDepot
    : BQ_Depot<Trailer, TrailersDepot, Database> {
    public Q_TrailersDepot()
        : base(nameof(Trailer.Id)) {
    }

    protected override Trailer MockFactory(string RandomSeed) {

        return new() {
            Common = new() {
                Status = new Status { Id = 1},
                Timestamp = DateTime.Now,
                Economic = RandomUtils.String(16),
            },
            Carrier = new() {
                Status = new Status {
                    Id = 1,
                },
                Name = RandomUtils.String(10),
                Approach = new() {
                    Status = new Status { Id = 1 },
                    EMail = RandomUtils.String(30)
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