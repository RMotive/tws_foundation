
using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="AddressesDepot"/>.
/// </summary>
public class Q_WaypointsDepot
    : BQ_Depot<Waypoint, WaypointsDepot, TWSBusinessDatabase> {
    public Q_WaypointsDepot()
        : base(nameof(Waypoint.Id)) {
    }

    protected override Waypoint MockFactory(string RandomSeed) {

        return new() {
            Status = 1,
            Longitude = 10.0M,
            Latitude = 9.0M,
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Waypoint Mock)
    => null;
}