
using TWS_Business.Depots;
using TWS_Business.Entities;

namespace TWS_Business.Quality.Q_Depots;

public class Q_Approaches
    : BQ_Business<Approach, ApproachesDepot> {

    protected override Approach EntityFactory(string Entropy) {

        return new Approach {
            EMail = Entropy,
            Enterprise = Entropy[..13],
            Personal = Entropy[..13],
            Alternative = Entropy[..13],
            Status = new Status {
                Name = Entropy,
                Description = Entropy,
            },
        };
    }
}

