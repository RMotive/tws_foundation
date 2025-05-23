using TWS_Business.Depots.Vehicles;
using TWS_Business.Entities;
using TWS_Business.Entities.Vehicules;

namespace TWS_Business.Quality.Q_Depots;

public class Q_Carriers : BQ_Business<Carrier, CarriersDepot> {

    protected override Carrier EntityFactory(string Entropy) {

        return new Carrier {
            Name = Entropy,
            Status = new Status {
                Name = Entropy,
            },
            Approach = new Approach {
                EMail = Entropy,
                Status = new Status {
                    Name = "A" + Entropy,
                }
            },
            Address = new Address {
                State = Entropy[..3],
                Street = Entropy,
                AltStreet = Entropy,
                City = Entropy,
                ZIP = Entropy[..5],
                Country = Entropy[..3],
                Subdivision = Entropy,
            }
        };
    }
}
