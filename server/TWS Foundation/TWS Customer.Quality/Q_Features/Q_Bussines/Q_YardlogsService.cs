using TWS_Business.Depots.Vehicles.Control;

using TWS_Customer.Features.Business;


namespace TWS_Customer.Quality.Q_Features.Q_Bussines;

public class Q_YardlogsService
    : BQ_ServicesCustomer<IYardLogsService> {

    private YardLogsDepot? _depot;

    #region [BQ_Service] implementations
    protected override IYardLogsService ServiceFactory() {
        TWS_Business.Database BussinesDatabase = BusinessDatabaseFactory();
        IYardLogsDepot YardlogsDepot = new YardLogsDepot(BussinesDatabase, Disposer);
        _depot = new YardLogsDepot(BussinesDatabase, Disposer);

        return new YardLogsService(YardlogsDepot);
    }
    #endregion

}
