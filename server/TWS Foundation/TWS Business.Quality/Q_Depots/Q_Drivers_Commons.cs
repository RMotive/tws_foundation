using TWS_Business.Depots;
using TWS_Business.Entities;
using TWS_Business.Entities.Drivers;

namespace TWS_Business.Quality.Q_Depots;

public class Q_Drivers_Commons : BQ_Business<Driver_Common, Drivers_CommonsDepot> {

    protected override Driver_Common EntityFactory(string Entropy) {
        DateOnly date = new(2030, 11, 11);

        Situation situation = Store(
                new Situation {
                    Name = Entropy,
                    Description = Entropy,
                }
            );

        Status status = Store(
                new Status {
                    Name = Entropy,
                    Description = Entropy,
                }
            );

        Identification identification = Store(
                  new Identification {
                      Name = Entropy,
                      Lastname = Entropy,
                      Status = status,
                  }
             );

        return new Driver_Common {
            License = Entropy[..12],
            Situation = situation,
            Status = status,
           
        };
    }
}
