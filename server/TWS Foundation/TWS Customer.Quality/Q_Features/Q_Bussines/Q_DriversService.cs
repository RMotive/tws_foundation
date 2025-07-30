using TWS_Business.Entities.Drivers;

using TWS_Customer.Features.Business;

namespace TWS_Customer.Quality.Q_Features.Q_Bussines;
public class Q_DriversService
    : BQ_Service<IDriversService, Driver_Common> {

    protected override Driver_Common DraftEntity(string entropy) {
        throw new NotImplementedException();
    }

    protected override IDriversService ServiceFactory() {
        throw new NotImplementedException();
    }
}