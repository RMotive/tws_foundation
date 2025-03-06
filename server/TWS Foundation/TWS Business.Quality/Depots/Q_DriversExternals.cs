using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality;

using TWS_Business.Depots;
using TWS_Business.Entities;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="DriversExternalsDepot"/>.
/// </summary>
public class Q_DriversExternals
    : BQ_Depot<DriverExternal, DriversExternalsDepot, Database> {
    public Q_DriversExternals()
        : base(nameof(DriverExternal.Id)) {
    }

    protected override DriverExternal MockFactory(string RandomSeed) {

        return new() {
            Identification = new Identification {
                Id = 1,
            },
            Common = new() {
                Timestamp = DateTime.Now,
                Status = new Status { Id = 1 },
                License = RandomUtils.String(12)
            }
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(DriverExternal Mock) {
        return null;
    }
}