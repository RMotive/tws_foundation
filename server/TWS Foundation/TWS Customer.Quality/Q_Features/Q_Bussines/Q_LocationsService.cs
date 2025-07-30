using TWS_Business.Depots;

using TWS_Customer.Features.Business;

using Location = TWS_Business.Entities.Location;

namespace TWS_Customer.Quality.Q_Features.Q_Bussines;

public class Q_LocationsService
    : BQ_Service<ILocationsService, Location> {

    private LocationsDepot? _depot;

    protected override ILocationsService ServiceFactory() {
        TWS_Business.Database businessDb = BuildBusinessDb();

        return new LocationsService(
            new LocationsDepot(
                    businessDb,
                    Disposer
                ),
            businessDb
            );
    }
    protected override Location DraftEntity(string entropy) {
        throw new NotImplementedException();
    }
}
