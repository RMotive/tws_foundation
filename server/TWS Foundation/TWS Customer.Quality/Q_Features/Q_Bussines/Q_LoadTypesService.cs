using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business.Depots.Vehicles;
using TWS_Business.Entities.Vehicules;
using TWS_Business.Quality.Utils;

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

    [Fact(DisplayName = "[Read]: Read a record filtering by reference property.")]
    public async Task Read() {
        // Create a sample to prevent empty read results.
        LoadType load = Store(BusinessDraftUtils.SampleLoadtype());
        BatchOperationOutput<LoadType> batchResult = await service.Read(load.Reference);

        Assert.Multiple(
            () => Assert.True(batchResult.SuccessesCount > 0),
            () => Assert.Equal(0, batchResult.FailuresCount),
            () => Assert.Single(batchResult.Successes)
        );
    }
}