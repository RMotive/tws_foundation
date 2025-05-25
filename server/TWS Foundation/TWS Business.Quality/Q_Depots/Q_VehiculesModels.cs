using TWS_Business.Depots.Vehicles;
using TWS_Business.Entities;
using TWS_Business.Entities.Vehicules;

namespace TWS_Business.Quality.Q_Depots;

public class Q_VehiculeModels : BQ_Business<VehiculeModel, VehiculeModelsDepot> {

    protected override VehiculeModel EntityFactory(string Entropy) {
        DateOnly date = new(2030, 11, 11);
        Status status = Store(
                new Status {
                    Name = Entropy,
                }
            );

        Manufacturer manufacturer = Store(
                new Manufacturer {
                    Name = Entropy,
                    Description = Entropy,
                }
            );
        

        return new VehiculeModel {
            Name = Entropy,
            Year = date, 
            Manufacturer = manufacturer,
            Status = status,
        };
    }
}
