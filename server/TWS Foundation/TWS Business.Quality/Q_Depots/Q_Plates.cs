using TWS_Business.Depots.Vehicles;
using TWS_Business.Entities;
using TWS_Business.Entities.Vehicules;

namespace TWS_Business.Quality.Q_Depots;

public class Q_Plates : BQ_Business<Plate, PlatesDepot> {

    protected override Plate EntityFactory(string Entropy) {

        Status status = Store(
                new Status {
                    Name = Entropy,
                }
            );
        return new Plate {
            Identifier = Entropy[..12],
            Country = Entropy[..3],
            Status = status,
        };
    }
}
