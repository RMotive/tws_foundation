using TWS_Business.Entities.Vehicules.Trucks;

using TWS_Customer.Features.Business;

namespace TWS_Customer.Quality.Q_Features.Q_Bussines;
public class Q_TrucksService
    : BQ_Service<ITrucksCommonService, Truck_Common> {

    protected override Truck_Common DraftEntity(string entropy) {
        throw new NotImplementedException();
    }
    protected override ITrucksCommonService ServiceFactory() {
        throw new NotImplementedException();
    }
}