using TWS_Business.Entities;

using TWS_Customer.Features.Business;


namespace TWS_Customer.Quality.Q_Features.Q_Bussines;

public class Q_AddressesService
    : BQ_Service<IAddressesService, Address> {

    protected override Address DraftEntity(string entropy) {
        throw new NotImplementedException();
    }

    protected override IAddressesService ServiceFactory() {
        throw new NotImplementedException();
    }
}
