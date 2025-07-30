using TWS_Business.Entities;

using TWS_Customer.Features.Business;


namespace TWS_Customer.Quality.Q_Features.Q_Bussines;

public class Q_YardlogsService
    : BQ_Service<IYardLogsService, YardLog> {

    protected override YardLog DraftEntity(string entropy) {
        throw new NotImplementedException();
    }

    protected override IYardLogsService ServiceFactory() {
        throw new NotImplementedException();
    }
}
