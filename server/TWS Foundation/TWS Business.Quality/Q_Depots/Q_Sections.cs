using TWS_Business.Depots.Directories;
using TWS_Business.Entities;

namespace TWS_Business.Quality.Q_Depots;

public class Q_Sections
    : BQ_Business<Section, SectionsDepot> {

    protected override Section EntityFactory(string Entropy) {
        Status status = Store(
                new Status {
                    Name = Entropy,
                    Description = Entropy,
                }
            );

        Status status2 = Store(
                new Status {
                    Name = "a" + Entropy,
                    Description = "a" + Entropy,
                }
            );

        Address address = Store(
                new Address {
                    State = Entropy[..3],
                    Street = Entropy,
                    AltStreet = Entropy,
                    City = Entropy,
                    ZIP = Entropy[..5],
                    Country = Entropy[..3],
                    Subdivision = Entropy,
                }
            );

        Location location = Store(
                new Location {
                    Name = Entropy,
                    Description = Entropy,
                    Status = status2,
                    Address = address,
                }
            );

        return new Section {
            Name = Entropy,
            Capacity = 10,
            Ocupancy = 1,
            Status = status,
            Yard = location
        };
    }
}

