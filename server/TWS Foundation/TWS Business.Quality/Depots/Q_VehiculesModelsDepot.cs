using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="VehiculesModelsDepot"/>.
/// </summary>
public class Q_VehiculesModelsDepot
    : BQ_Depot<VehiculeModel, VehiculesModelsDepot, TWSBusinessDatabase> {
    public Q_VehiculesModelsDepot()
        : base(nameof(VehiculeModel.Id)) {
    }

    protected override VehiculeModel MockFactory(string RandomSeed) {

        return new() {
            Status = 1,
            Name = RandomUtils.String(20),
            Year = DateOnly.MinValue,
            ManufacturerNavigation = new Manufacturer() {
                Name = RandomUtils.String(20)
            }
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(VehiculeModel Mock)
    => (nameof(VehiculeModel.Name), Mock.Name);
}