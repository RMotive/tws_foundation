using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="TrucksInventoriesDepot"/>.
/// </summary>
public class Q_TrucksInventories
    : BQ_Depot<TruckInventory, TrucksInventoriesDepot, TWSBusinessDatabase> {
    public Q_TrucksInventories()
        : base(nameof(TruckInventory.Id)) {
    }

    protected override TruckInventory MockFactory(string RandomSeed) {

        return new() {
            EntryDate = DateTime.Now,
            Section = 1,
            TruckExternalNavigation = new() {
                Common = 0,
                Status = 1,
                Carrier = "Carrier " + RandomUtils.String(5),
                MxPlate = RandomUtils.String(10),
                TruckCommonNavigation = new() {
                    Status = 1,
                    Economic = RandomUtils.String(16),
                }
            }
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(TruckInventory Mock)
    => null;
}