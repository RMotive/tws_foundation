using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

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

    [Fact(DisplayName = "[Read]: Read a record filtering by reference property.")]
    public async Task Read() {
        // Create a sample to prevent empty read results.
        Situation situation = await _depot!.Store(SampleSituation(), true);
        BatchOperationOutput<Situation> batchResult = await _service.Read(situation.Reference);

        Assert.Multiple(
            () => Assert.True(batchResult.SuccessesCount > 0),
            () => Assert.Equal(0, batchResult.FailuresCount),
            () => Assert.Single(batchResult.Successes)
        );
    }
}

