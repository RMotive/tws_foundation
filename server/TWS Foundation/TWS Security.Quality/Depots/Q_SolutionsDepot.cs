using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Security.Entities.Solutions;

namespace TWS_Security.Quality.Depots;

/// <summary>
///     Qualifies the <see cref="SolutionsDepot"/>.
/// </summary>
public class Q_SolutionsDepot
    : BQ_Depot<Solution, SolutionsDepot, SecurityDatabase> {
    public Q_SolutionsDepot()
        : base(nameof(Solution.Name)) {
    }

    protected override Solution MockFactory(string RandomSeed) {
        return new() {
            Sign = RandomUtils.String(5),
            Name = RandomUtils.String(15),
            Description = "Q_DescriptionToken"
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Solution Mock) {
        return (nameof(Solution.Name), Mock.Name);
    }
}
