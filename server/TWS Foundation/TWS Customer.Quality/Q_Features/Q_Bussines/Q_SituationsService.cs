using TWS_Business.Depots.Indicators;
using TWS_Business.Entities;

using TWS_Customer.Features.Business;

namespace TWS_Customer.Quality.Q_Features.Q_Bussines;
public class Q_SituationsService
    : BQ_Service<ISituationsService, Situation> {

    protected override ISituationsService ServiceFactory() {
        TWS_Business.Database businessDb = BuildBusinessDb();

        return new SituationsService(
            new SituationsDepot(
                    businessDb,
                    Disposer
                )
            );
    }

    protected override Situation DraftEntity(string entropy) {
        throw new NotImplementedException();
    }
}

