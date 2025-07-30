using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business.Depots;
using TWS_Business.Depots.Vehicles;
using TWS_Business.Entities.Vehicules;

using TWS_Customer.Features.Business.Vehicules;

namespace TWS_Customer.Quality.Q_Features.Q_Bussines;
public class Q_LoadTypesService
    : BQ_Service<ILoadTypesService, LoadType> {

    protected override ILoadTypesService ServiceFactory() {
        TWS_Business.Database businessDb = BuildBusinessDb();

        return new LoadTypesService(
            new LoadTypesDepot(
                    businessDb,
                    Disposer
                ), 
            businessDb
            );
    }

    protected override LoadType DraftEntity(string entropy) {
        throw new NotImplementedException();
    }
}