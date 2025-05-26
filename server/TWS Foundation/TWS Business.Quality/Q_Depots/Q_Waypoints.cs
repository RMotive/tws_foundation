using TWS_Business.Depots;
using TWS_Business.Entities;

namespace TWS_Business.Quality.Q_Depots;

public class Q_Waypoints : BQ_Business<Waypoint, WaypointsDepot> {

    protected override Waypoint EntityFactory(string Entropy) {
        Location location = Store(
                new Location {
                    Name = Entropy,
                    Status = Store(
                        new Status {
                            Name = Entropy,
                            Reference = Entropy[..8],
                        }
                    ),
                    Address = Store(
                        new Address {
                            State = Entropy[..3],
                            Street = Entropy,
                            AltStreet = Entropy,
                            City = Entropy,
                            ZIP = Entropy[..5],
                            Country = Entropy[..3],
                            Subdivision = Entropy,
                        }
                    )
                }
            );

        return new Waypoint {
            Latitude = 123,
            Longitude = 212,
            Location = location
        };
    }
}
