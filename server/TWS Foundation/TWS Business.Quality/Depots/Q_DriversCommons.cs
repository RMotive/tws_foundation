using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality;

using TWS_Business.Depots;
using TWS_Business.Entities;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="DriversCommonsDepot"/>.
/// </summary>
public class Q_DriversCommons
    : BQ_Depot<DriverCommon, DriversCommonsDepot, BusinessDatabase> {
    public Q_DriversCommons()
        : base(nameof(DriverCommon.Id)) {
    }

    protected override DriverCommon MockFactory(string RandomSeed) {

        return new() {
            License = RandomUtils.String(12),
            Status = 1
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(DriverCommon Mock) 
    => (nameof(DriverCommon.License), Mock.License);
}