using TWS_Business.Depots.Vehicles;
using TWS_Business.Entities.Vehicules;

namespace TWS_Business.Quality.Q_Depots;

public class Q_Manufacturers : BQ_Business<Manufacturer, ManufacturersDepot> {

    protected override Manufacturer EntityFactory(string Entropy) {

        return new Manufacturer {
            Name = Entropy,
            Description = Entropy,
        };
    }
}
