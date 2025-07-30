using TWS_Business.Depots.Vehicles;
using TWS_Business.Entities.Vehicules;

using TWS_Customer.Features.Business.Vehicules;

namespace TWS_Customer.Quality.Q_Features.Q_Bussines;
public class Q_ManufacturersService
    : BQ_Service<IManufacturersService, Manufacturer> {

    protected override IManufacturersService ServiceFactory() {
        TWS_Business.Database businessDb = BuildBusinessDb();

        return new ManufacturersService(
            new ManufacturersDepot(
                    businessDb,
                    Disposer
                ),
            businessDb
            );
    }

    protected override Manufacturer DraftEntity(string entropy) {
        throw new NotImplementedException();
    }
}
