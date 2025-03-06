using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality;

using TWS_Business.Entities;
using TWS_Business.Entities.Trucks;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="TrucksInventoriesDepot"/>.
/// </summary>
public class Q_TrucksInventories
    : BQ_Depot<TruckEntry, TruckInventory, BusinessDatabase> {
    public Q_TrucksInventories()
        : base(nameof(TruckEntry.Id)) {
    }

    protected override TruckEntry MockFactory(string RandomSeed) {
        return new() {
            Section = new Section { Id = 1 },
            Truck = new() {
                External = new TruckExternal {
                    Carrier = "CarrierHistory " + RandomUtils.String(5),
                    MxPlate = RandomUtils.String(10),
                    Common = new() {
                        Status = new Status { Id = 1 },
                        Economic = RandomUtils.String(16),
                    },
                },
            },
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(TruckEntry Mock) {
        throw new NotImplementedException();
    }
}