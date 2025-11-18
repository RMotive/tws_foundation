using TWS_Business.Depots.Vehicles.Control;
using TWS_Business.Entities;
using TWS_Business.Quality.Utils;

using TWS_Customer.Features.Business;


namespace TWS_Customer.Quality.Q_Features.Q_Bussines;

public class Q_YardlogsService
    : BQ_Service<IYardLogsService, YardLog> {

    protected override YardLog DraftEntity(string entropy) {
        return BusinessDraftUtils.SampleYardlog();
    }

    protected override IYardLogsService ServiceFactory() {
        TWS_Business.Database businessDatabase = BuildBusinessDb();
        YardLogsDepot depot = new(businessDatabase, Disposer);
        return new YardLogsService(depot);
    }
}
