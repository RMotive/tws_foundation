using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="YardLogsDepot"/>.
/// </summary>
public class Q_YardLogsDepot
    : BQ_MigrationDepot<YardLog, YardLogsDepot, TWSBusinessDatabase> {
    public Q_YardLogsDepot()
        : base(nameof(YardLog.Id)) {
    }

    protected override YardLog MockFactory() {

        return new() {
            Entry = true,
            LoadType = 1,
            Section = 1,
            Timestamp = DateTime.Now,
            Guard = 1,
            Truck = 1,
            Seal = " seal",
            Gname = RandomUtils.String(30),
            FromTo = RandomUtils.String(30),
            Damage = false,
            TTPicture = RandomUtils.String(30),
        };
    }
}