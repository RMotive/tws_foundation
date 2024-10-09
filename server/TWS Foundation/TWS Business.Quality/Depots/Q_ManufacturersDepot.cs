using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="ManufacturersDepot"/>.
/// </summary>
public class Q_ManufacturersDepot
    : BQ_Depot<Manufacturer, ManufacturersDepot, TWSBusinessDatabase> {
    public Q_ManufacturersDepot()
        : base(nameof(Manufacturer.Id)) {
    }

    protected override Manufacturer MockFactory(string RandomSeed) {
        DateOnly date = new(2024, 12, 12);

        return new() {
            Name = RandomUtils.String(20),
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Manufacturer Mock) {
        return (nameof(Manufacturer.Name), Mock.Name);
    }
}