using TWS_Business.Depots.Vehicles;
using TWS_Business.Entities;
using TWS_Business.Entities.Vehicules;

namespace TWS_Business.Quality.Q_Depots;

public class Q_SCT : BQ_Business<SCT, SCTDepot> {

    protected override SCT EntityFactory(string Entropy) {
        Status status = Store(
                new Status {
                    Name = Entropy,
                }
            );

        return new SCT {
            Type = Entropy[..6],
            Number = Entropy + Entropy[..9],
            Configuration = Entropy[..10],
            Status = status,
        };
    }
}
