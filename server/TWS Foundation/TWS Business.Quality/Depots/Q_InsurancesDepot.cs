using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="InsurancesDepot"/>.
/// </summary>
public class Q_InsurancesDepot
    : BQ_Depot<Insurance, InsurancesDepot, TWSBusinessDatabase> {
    public Q_InsurancesDepot()
        : base(nameof(Insurance.Policy)) {
    }

    protected override Insurance MockFactory(string RandomSeed) {
        DateOnly date = new(2024, 12, 12);

        return new() {
            Policy = RandomUtils.String(5),
            Country = RandomUtils.String(3),
            Status = 1,
            Expiration = date
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Insurance Mock) {
        return (nameof(Insurance.Policy), Mock.Policy);
    }
}