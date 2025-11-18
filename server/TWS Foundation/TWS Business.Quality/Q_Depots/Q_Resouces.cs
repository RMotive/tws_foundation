using TWS_Business.Depots;
using TWS_Business.Entities;

namespace TWS_Business.Quality.Q_Depots;
public class Q_Resouces : BQ_Business<Resource, ResourcesDepot> {

    protected override Resource EntityFactory(string Entropy) {
        return new Resource {
            Extension = Entropy[..3],
        };
    }
}

