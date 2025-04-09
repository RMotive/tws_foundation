using TWS_Business.Depots.Vehicles;
using TWS_Business.Entities;
using TWS_Business.Entities.Vehicules;

namespace TWS_Business.Quality.Q_Depots;

public class Q_LoadTypes : BQ_Business<LoadType, LoadTypesDepot> {

    protected override LoadType EntityFactory(string Entropy) {

        return new LoadType {
            Name = Entropy,
            Description = Entropy,
        };
    }
}
