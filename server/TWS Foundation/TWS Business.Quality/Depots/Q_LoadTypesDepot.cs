using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="LoadTypesDepot"/>.
/// </summary>
public class Q_LoadTypesDepot
    : BQ_Depot<LoadType, LoadTypesDepot, TWSBusinessDatabase> {
    public Q_LoadTypesDepot()
        : base(nameof(LoadType.Id)) {
    }

    protected override LoadType MockFactory(string RandomSeed) {

        return new() {
            Name = RandomUtils.String(20),
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(LoadType Mock) {
        return (nameof(LoadType.Name), Mock.Name);
    }
}