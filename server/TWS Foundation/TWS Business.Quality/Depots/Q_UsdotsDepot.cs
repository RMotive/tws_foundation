using CSM_Foundation.Database.Quality;

using TWS_Business.Entities;
using TWS_Business.Entities.USDOTs;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="USDOTsDepot"/>.
/// </summary>
public class Q_UsdotsDepot
    : BQ_Depot<USDOT, USDOTsDepot, Database> {
    public Q_UsdotsDepot()
        : base(nameof(USDOT.MC)) {
    }

    protected override USDOT MockFactory(string RandomSeed) {
        return new() {
            Status = new Status { Id = 1 },
            MC = "MCtestT",
            SCAC = "SCAT"
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(USDOT Mock) {
        return (nameof(USDOT.MC), Mock.MC);
    }
}