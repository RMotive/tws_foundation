using CSM_Foundation.Core.Utils;
using CSM_Foundation.Databases.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="DriversCommonsDepot"/>.
/// </summary>
public class Q_DriversCommons
    : BQ_MigrationDepot<DriverCommon, DriversCommonsDepot, TWSBusinessDatabases> {
    public Q_DriversCommons()
        : base(nameof(DriverCommon.Id)) {
    }

    protected override DriverCommon MockFactory() {

        return new() {
            License = RandomUtils.String(12),
            Status = 1
        };
    }
}