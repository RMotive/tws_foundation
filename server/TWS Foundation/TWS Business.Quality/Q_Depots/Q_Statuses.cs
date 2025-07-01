

using TWS_Business.Depots.Indicators;
using TWS_Business.Entities;

namespace TWS_Business.Quality.Q_Depots;

public class Q_Statuses : BQ_Business<Status, StatusesDepot>{

    protected override Status EntityFactory(string Entropy) {
        return new Status {
            Name = Entropy,
            Reference = Entropy[..8],
        };
    }
}
