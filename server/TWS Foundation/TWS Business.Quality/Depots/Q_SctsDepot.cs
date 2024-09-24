using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="SctsDepot"/>.
/// </summary>
public class Q_SctsDepot
    : BQ_Depot<Sct, SctsDepot, TWSBusinessDatabase> {
    public Q_SctsDepot()
        : base(nameof(Sct.Type)) {
    }

    protected override Sct MockFactory(string RandomSeed) {
        return new() {
            Type = RandomUtils.String(6),
            Number = RandomUtils.String(25),
            Configuration = RandomUtils.String(10),
            Status = 1
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Sct Mock) {
        return (nameof(Sct.Number), Mock.Number);
    }
}