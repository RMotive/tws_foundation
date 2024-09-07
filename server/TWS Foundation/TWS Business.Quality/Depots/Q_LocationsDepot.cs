using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="LocationsDepot"/>.
/// </summary>
public class Q_LocationsDepot
    : BQ_Depot<Location, LocationsDepot, TWSBusinessDatabase> {
    public Q_LocationsDepot()
        : base(nameof(Location.Name)) {
    }

    protected override Location MockFactory(string RandomSeed) {

        return new() {
            Name = RandomUtils.String(10),
            Address = 1,
            Status = 1
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Location Mock) {
        return (nameof(Location.Name), Mock.Name);
    }
}