using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality;

using TWS_Business.Depots;
using TWS_Business.Entities;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="LocationsDepot"/>.
/// </summary>
public class Q_LocationsDepot
    : BQ_Depot<Location, LocationsDepot, BusinessDatabase> {
    public Q_LocationsDepot()
        : base(nameof(Location.Name)) {
    }

    protected override Location MockFactory(string RandomSeed) {

        return new() {
            Name = RandomUtils.String(10),
            Address = new Address {
                Id = 1,
            },
            Status = new Status {
                Id = 1,
            }
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Location Mock) {
        return (nameof(Location.Name), Mock.Name);
    }
}