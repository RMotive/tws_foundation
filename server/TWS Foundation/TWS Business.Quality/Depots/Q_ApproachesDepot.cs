using CSM_Foundation.Database.Quality;

using TWS_Business.Depots;
using TWS_Business.Entities;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="ApproachesDepot"/>.
/// </summary>
public class Q_ApproachesDepot
    : BQ_Depot<Approach, ApproachesDepot, BusinessDatabase> {
    public Q_ApproachesDepot()
        : base(nameof(Approach.EMail)) {
    }

    protected override Approach MockFactory(string RandomSeed) {
        return new() {
            Status = new Status {
                Id = 1,
            },
            EMail = "mail@test.com"
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Approach Mock) {
        return (nameof(Approach.Personal), Mock.Personal);
    }
}