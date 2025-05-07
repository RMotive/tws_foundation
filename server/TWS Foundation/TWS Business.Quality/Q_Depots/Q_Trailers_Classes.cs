using TWS_Business.Depots;
using TWS_Business.Entities;
using TWS_Business.Entities.Vehicules.Trailers;

namespace TWS_Business.Quality.Q_Depots;

public class Q_Trailer_Classes : BQ_Business<Trailer_Class, TrailerClassesDepot> {

    protected override Trailer_Class EntityFactory(string Entropy) {

        return new Trailer_Class {
            Name = Entropy,
            
        };
    }
}
