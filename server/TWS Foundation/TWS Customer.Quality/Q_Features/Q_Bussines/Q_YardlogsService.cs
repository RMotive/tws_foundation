using CSM_Database_Core.Depots.Models;

using TWS_Business.Depots.Vehicles.Control;
using TWS_Business.Entities;
using TWS_Business.Quality.Utils;

using TWS_Customer.Features.Business;


namespace TWS_Customer.Quality.Q_Features.Q_Bussines;

public class Q_YardlogsService
    : BQ_Service<YardLogsService, YardLog> {

    protected override YardLog DraftEntity(string entropy) {
        return BusinessDraftUtils.SampleYardlog();
    }

    protected override YardLogsService ServiceFactory() {
        TWS_Business.Database businessDatabase = BuildBusinessDb();
        CSM_Security.Database securityDatabase = BuildSecurityDb();

        YardLogsDepot depot = new(businessDatabase, securityDatabase, Disposer);
        return new YardLogsService(depot);
    }

    [Fact(DisplayName = "[View]: Trailers Inventory view")]
    public async Task InventoryTrailersView() {

        ViewOutput<YardLog> view = await service.InventoryTrailerView(new QueryInput<YardLog, ViewInput<YardLog>> {
            Parameters = new ViewInput<YardLog> {
                Retroactive = false,
                Range = 10,
                Page = 1,
            }
        });

        Assert.True(view.Count > 0);
        Assert.True(view.Page > 0);
        Assert.True(view.Entities.Length > 0);
    }
}
