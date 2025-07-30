using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business.Depots.Directories;
using TWS_Business.Entities;

using TWS_Customer.Features.Business;


namespace TWS_Customer.Quality.Q_Features.Q_Bussines;

public class Q_SectionsService
    : BQ_Service<ISectionsService, Section> {

    private SectionsDepot? _depot;

    protected override ISectionsService ServiceFactory() {
        TWS_Business.Database businessDb = BuildBusinessDb();

        return new SectionsService(
            new SectionsDepot(
                    businessDb,
                    Disposer
                ), 
            businessDb
            );
    }

    protected override Section DraftEntity(string entropy) {
        throw new NotImplementedException();
    }
}
