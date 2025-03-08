using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality;

using TWS_Business.Depots;
using TWS_Business.Entities;
using TWS_Business.Entities.Vehicules;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="VehiculesModelsDepot"/>.
/// </summary>
public class Q_VehiculesModelsDepot
    : BQ_Depot<VehiculeModel, VehiculesModelsDepot, Database> {
    public Q_VehiculesModelsDepot()
        : base(nameof(VehiculeModel.Id)) {
    }

    protected override VehiculeModel MockFactory(string RandomSeed) {

        return new() {
            Status = new Status { Id = 1 },
            Name = RandomUtils.String(20),
            Year = DateOnly.MinValue,
            Manufacturer = new Manufacturer() {
                Name = RandomUtils.String(20)
            }
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(VehiculeModel Mock) {
        return (nameof(VehiculeModel.Name), Mock.Name);
    }
}