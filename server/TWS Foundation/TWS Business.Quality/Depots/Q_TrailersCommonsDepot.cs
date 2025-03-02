using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality;

using TWS_Business.Depots;
using TWS_Business.Entities;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="TrailersCommonsDepot"/>.
/// </summary>
public class Q_TrailersCommonsDepot
    : BQ_Depot<TrailerCommon, TrailersCommonsDepot, BusinessDatabase> {
    public Q_TrailersCommonsDepot()
        : base(nameof(TrailerCommon.Id)) {
    }

    protected override TrailerCommon MockFactory(string RandomSeed) {

        return new() {
            Status = new Status { Id = 1},
            Economic = RandomUtils.String(16),
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(TrailerCommon Mock) {
        return (nameof(TrailerCommon.Economic), Mock.Economic);
    }
}