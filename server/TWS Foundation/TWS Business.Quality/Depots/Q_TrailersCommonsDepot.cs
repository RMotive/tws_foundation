using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality;

using TWS_Business.Entities;
using TWS_Business.Entities.Trailers;
using TWS_Business.Entities.Vehicules.Trailers;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="TrailersCommonsDepot"/>.
/// </summary>
public class Q_TrailersCommonsDepot
    : BQ_Depot<Trailer_Common, TrailersCommonsDepot, Database> {
    public Q_TrailersCommonsDepot()
        : base(nameof(Trailer_Common.Id)) {
    }

    protected override Trailer_Common MockFactory(string RandomSeed) {

        return new() {
            Status = new Status { Id = 1},
            Economic = RandomUtils.String(16),
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Trailer_Common Mock) {
        return (nameof(Trailer_Common.Economic), Mock.Economic);
    }
}