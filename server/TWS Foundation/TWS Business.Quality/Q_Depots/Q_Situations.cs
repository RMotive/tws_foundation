using TWS_Business.Depots.Indicators;
using TWS_Business.Entities;

namespace TWS_Business.Quality.Q_Depots;

public class Q_Situations : BQ_Business<Situation, SituationsDepot> {

    protected override Situation EntityFactory(string Entropy) {

        return new Situation {
            Name = Entropy,
            Description = Entropy,
        };
    }
}
