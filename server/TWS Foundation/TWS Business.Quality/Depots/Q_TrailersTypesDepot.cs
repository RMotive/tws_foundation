using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality;

using TWS_Business.Entities;
using TWS_Business.Entities.Trailers;
using TWS_Business.Entities.Vehicules.Trailers;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="TrailersTypesDepot"/>.
/// </summary>
public class Q_TrailersTypesDepot
    : BQ_Depot<Trailer_Type, TrailersTypesDepot, Database> {
    public Q_TrailersTypesDepot()
        : base(nameof(Trailer_Type.Id)) {
    }

    protected override Trailer_Type MockFactory(string RandomSeed) {

        return new() {
            Status = new Status { Id = 1 },
            Size = RandomUtils.String(10),
            Class = new() {
                Name = RandomUtils.String(10)
            }
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Trailer_Type Mock)
    => (nameof(Trailer_Type.Size), Mock.Size);
}