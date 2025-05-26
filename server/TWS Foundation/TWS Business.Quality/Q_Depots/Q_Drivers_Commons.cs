using TWS_Business.Depots;
using TWS_Business.Entities;
using TWS_Business.Entities.Drivers;

namespace TWS_Business.Quality.Q_Depots;

public class Q_Drivers_Commons : BQ_Business<Driver_Common, Drivers_CommonsDepot> {

    protected override Driver_Common EntityFactory(string Entropy) {

        Situation situation = Store(
                new Situation {
                    Name = Entropy,
                    Description = Entropy,
                    Reference = Entropy[..8],
                }
            );

        Status status = Store(
                new Status {
                    Name = Entropy,
                    Description = Entropy,
                    Reference = Entropy[..8],
                }
            );

        Status statusI = Store(
                new Status {
                    Name = 'I' + Entropy,
                    Description = Entropy,
                    Reference = "I" + Entropy[..7],
                }
            );

        Identification identification = Store(
                  new Identification {
                      Name = Entropy,
                      Lastname = Entropy,
                      Status = statusI,
                  }
             );

        DriverExternal external = Store(
                new DriverExternal {
                    Identification = identification,
                }
            );

        return new Driver_Common {
            License = Entropy[..12],
            Situation = situation,
            Status = status,
            External = external,
        };
    }
}
