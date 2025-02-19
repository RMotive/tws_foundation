using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality;

using TWS_Business.Depots;
using TWS_Business.Entities;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="UsdotsDepot"/>.
/// </summary>
public class Q_UsdotsDepot
    : BQ_Depot<USDOT, UsdotsDepot, BusinessDatabase> {
    public Q_UsdotsDepot()
        : base(nameof(USDOT.Mc)) {
    }

    protected override USDOT MockFactory(string RandomSeed) {
        return new() {
            Status = 1,
            Mc = "MCtestT",
            Scac = "SCAT"
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(USDOT Mock) {
        return (nameof(USDOT.Mc), Mock.Mc);
    }
}