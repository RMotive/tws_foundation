using TWS_Business.Entities.Vehicules;

using TWS_Customer.Features.Business.Vehicules;

namespace TWS_Customer.Quality.Q_Features.Q_Bussines;
public class Q_VehiculeModelsService
    : BQ_Service<IVehiculeModelsService, VehiculeModel> {

    protected override VehiculeModel DraftEntity(string entropy) {
        throw new NotImplementedException();
    }

    protected override IVehiculeModelsService ServiceFactory() {
        throw new NotImplementedException();
    }
}

