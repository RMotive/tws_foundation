using CSM_Foundation.Database.Quality;

using TWS_Business.Entities;
using TWS_Business.Entities.Maintenances;

namespace TWS_Business.Quality.Depots;

/// <summary>
///     Qualifies the <see cref="MaintenacesDepot"/>.
/// </summary>
public class Q_MaintenancesDepot
    : BQ_Depot<Maintenance, MaintenacesDepot, Database> {
    public Q_MaintenancesDepot()
        : base(nameof(Maintenance.Trimestral)) {
    }

    protected override Maintenance MockFactory(string RandomSeed) {
        DateOnly date = new(2024, 12, 12);

        return new() {
            Trimestral = date,
            Anual = date,
            Status = new Status { Id = 1 }
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Maintenance Mock) {
        return null;
    }
}