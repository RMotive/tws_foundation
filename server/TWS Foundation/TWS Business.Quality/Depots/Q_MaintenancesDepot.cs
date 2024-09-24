using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;

/// <summary>
///     Qualifies the <see cref="MaintenacesDepot"/>.
/// </summary>
public class Q_MaintenancesDepot
    : BQ_Depot<Maintenance, MaintenacesDepot, TWSBusinessDatabase> {
    public Q_MaintenancesDepot()
        : base(nameof(Maintenance.Trimestral)) {
    }

    protected override Maintenance MockFactory(string RandomSeed) {
        DateOnly date = new(2024, 12, 12);

        return new() {
            Trimestral = date,
            Anual = date,
            Status = 1
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Maintenance Mock) {
        return null;
    }
}