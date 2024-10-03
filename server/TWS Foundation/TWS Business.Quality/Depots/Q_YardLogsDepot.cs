using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="YardLogsDepot"/>.
/// </summary>
public class Q_YardLogsDepot
    : BQ_Depot<YardLog, YardLogsDepot, TWSBusinessDatabase> {
    public Q_YardLogsDepot()
        : base(nameof(YardLog.Id)) {
    }

    protected override YardLog MockFactory(string RandomSeed) {

        return new() {
            Entry = true,
            LoadType = 1,
            Section = 1,
            Timestamp = DateTime.Now,
            Guard = 1,
            TruckExternal = 0,
            Seal = " seal",
            Gname = RandomUtils.String(30),
            FromTo = RandomUtils.String(30),
            Damage = false,
            TTPicture = RandomUtils.String(30),
            TruckExternalNavigation = new() {
                Status = 1,
                Common = 0,
                TruckCommonNavigation = new() {
                    Timestamp = DateTime.Now,
                    Status = 1,
                    Economic = RandomUtils.String(16),
                },
                MxPlate = "12345678",
                Carrier = "truck carrier qlty"
            }
    };
    }

    protected override (string Property, string? Value)? FactorizeProperty(YardLog Mock) {
        return null;
    }
}