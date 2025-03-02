using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality;

using TWS_Business.Depots;
using TWS_Business.Entities;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="TrailersTypesDepot"/>.
/// </summary>
public class Q_TrailersTypesDepot
    : BQ_Depot<TrailerType, TrailersTypesDepot, BusinessDatabase> {
    public Q_TrailersTypesDepot()
        : base(nameof(TrailerType.Id)) {
    }

    protected override TrailerType MockFactory(string RandomSeed) {

        return new() {
            Status = 1,
            Size = RandomUtils.String(10),
            Class = 0,
            TrailerClassNavigation = new() {
                Name = RandomUtils.String(10)
            }
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(TrailerType Mock)
    => (nameof(TrailerType.Size), Mock.Size);
}