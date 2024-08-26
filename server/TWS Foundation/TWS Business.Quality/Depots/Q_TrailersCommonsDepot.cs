using CSM_Foundation.Core.Utils;
using CSM_Foundation.Databases.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="TrailersCommonsDepot"/>.
/// </summary>
public class Q_TrailersCommonsDepot
    : BQ_MigrationDepot<TrailerCommon, TrailersCommonsDepot, TWSBusinessDatabases> {
    public Q_TrailersCommonsDepot()
        : base(nameof(TrailerCommon.Id)) {
    }

    protected override TrailerCommon MockFactory() {

        return new() {
            Class = 1,
            Status = 1,
            Economic = RandomUtils.String(16),
            Carrier = 1,
            Situation = 1,
            Location = 1
        };
    }
}