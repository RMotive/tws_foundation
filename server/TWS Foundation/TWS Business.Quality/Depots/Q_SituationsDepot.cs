

using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality;

using TWS_Business.Depots;
using TWS_Business.Entities;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="SituationsDepot"/>.
/// </summary>
public class Q_SituationsDepot
    : BQ_Depot<Situation, SituationsDepot, Database> {
    public Q_SituationsDepot()
        : base(nameof(Situation.Name)) {
    }

    protected override Situation MockFactory(string RandomSeed) {

        return new() {
            Name = RandomUtils.String(25),
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Situation Mock) {
        return (nameof(Situation.Name), Mock.Name);
    }
}
