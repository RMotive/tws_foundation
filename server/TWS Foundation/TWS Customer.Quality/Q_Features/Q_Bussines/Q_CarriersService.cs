using TWS_Business.Entities.Vehicules;

using TWS_Customer.Features.Business;


namespace TWS_Customer.Quality.Q_Features.Q_Bussines;

public class Q_CarriersService
    : BQ_Service<ICarriersService, Carrier> {

    protected override ICarriersService ServiceFactory() {
        throw new NotImplementedException();
    }

    protected override Carrier DraftEntity(string entropy) {
        throw new NotImplementedException();
    }
}
