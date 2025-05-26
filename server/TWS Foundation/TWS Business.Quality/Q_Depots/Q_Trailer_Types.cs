using TWS_Business.Entities;
using TWS_Business.Entities.Trailers;
using TWS_Business.Entities.Vehicules.Trailers;

namespace TWS_Business.Quality.Q_Depots;

public class Q_Trailer_Types : BQ_Business<Trailer_Type, TrailerTypesDepot> {

    protected override Trailer_Type EntityFactory(string Entropy) {

        return new Trailer_Type {
            Size = Entropy[..5],
            Status = Store(
                   new Status {
                       Name = Entropy,
                       Reference = Entropy[..8],
                   }
                ),
            Class = Store(
                    new Trailer_Class {
                        Name = Entropy[..10],
                    }
                ),
        };
    }
}
