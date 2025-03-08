using CSM_Foundation.Database.Quality;

using TWS_Business.Depots;
using TWS_Business.Entities;

namespace TWS_Business.Quality.Depots;

/// <summary>
///     Qualifies the <see cref="ApproachesDepot"/>.
/// </summary>
public class Q_ApproachesDepot
    : BQ_Depot<Approach, ApproachesDepot, Database> {

    protected override Approach EntityFactory(string Entropy) {
        return new() {
            Status = new Status {
                Id = 1,
            },
            EMail = $"{Entropy}@test.com"
        };
    }
}