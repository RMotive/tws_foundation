using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="StatusesDepot"/>.
/// </summary>
public class Q_StatusDepot
    : BQ_Depot<Status, StatusesDepot, TWSBusinessDatabase> {
    public Q_StatusDepot()
        : base(nameof(Status.Name)) {
    }

    protected override Status MockFactory(string RandomSeed) {

        return new() {
            Name = RandomUtils.String(25),
            Description = RandomUtils.String(100)
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Status Mock) {
        return (nameof(Status.Name), Mock.Name);
    }
}
