using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality;

using TWS_Business.Entities;
using TWS_Business.Entities.Insurances;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="InsurancesDepot"/>.
/// </summary>
public class Q_InsurancesDepot
    : BQ_Depot<Insurance, InsurancesDepot, BusinessDatabase> {
    public Q_InsurancesDepot()
        : base(nameof(Insurance.Policy)) {
    }

    protected override Insurance MockFactory(string RandomSeed) {
        DateOnly date = new(2024, 12, 12);

        return new() {
            Policy = RandomUtils.String(5),
            Country = RandomUtils.String(3),
            Status = new Status { Id = 1 },
            Expiration = date
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Insurance Mock) {
        return (nameof(Insurance.Policy), Mock.Policy);
    }
}