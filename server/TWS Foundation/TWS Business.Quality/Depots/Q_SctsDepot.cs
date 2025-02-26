using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality;

using TWS_Business.Depots;
using TWS_Business.Entities;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="SctsDepot"/>.
/// </summary>
public class Q_SctsDepot
    : BQ_Depot<SCT, SctsDepot, BusinessDatabase> {
    public Q_SctsDepot()
        : base(nameof(SCT.Type)) {
    }

    protected override SCT MockFactory(string RandomSeed) {
        return new() {
            Type = RandomUtils.String(6),
            Number = RandomUtils.String(25),
            Configuration = RandomUtils.String(10),
            Status = 1
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(SCT Mock) {
        return (nameof(SCT.Number), Mock.Number);
    }
}