using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business.Depots.Vehicles.Control;
using TWS_Business.Entities;

using TWS_Customer.Features.Business;


namespace TWS_Customer.Quality.Q_Features.Q_Bussines;

public class Q_YardlogsService
    : BQ_ServicesCustomer<IYardLogsService> {

    #region [BQ_Service] implementations
    protected override IYardLogsService ServiceFactory() {
        TWS_Business.Database BussinesDatabase = BusinessDatabaseFactory();

        IYardLogsDepot YardlogsDepot = new YardLogsDepot(BussinesDatabase, Disposer);

        return new YardLogsService(YardlogsDepot);
    }
    #endregion

    #region Private Methods/Functions

    YardLog EntityFactory() {
        return new YardLog {
            Entry = true,
            FromTo = Entropy,
            Evidence = [],
            Seal = Entropy[..10],
            LoadType = SampleLoadtype(),
            Guard = SampleEmployee(),
            Section = SampleSection(),
            Truck = SampleTruckCommon(true),
            Trailer = SampleTrailerCommon(true),
            Driver = SampleDriverCommon(true),
        };
    }

    #endregion

    [Fact(DisplayName = "[View]: Generates correctly a simple 1 page, 10 range view.")]
    public async Task View() {
        // Create a sample to prevent empty view results.
        SampleTrailerType();
        ViewOutput<YardLog> viewOutput = await _service.View(
                new QueryInput<YardLog, ViewInput<YardLog>> {
                    Parameters = new() {
                        Retroactive = false,
                        Range = 10,
                        Page = 1,
                    }
                }
            );

        Assert.Multiple(
            () => Assert.True(viewOutput.Pages > 0),
            () => Assert.True(viewOutput.Length > 0),
            () => Assert.Equal(1, viewOutput.Page),
            () => Assert.Equal(viewOutput.Length, viewOutput.Entities.Length)
        );
    }

    [Fact(DisplayName = "[Create]: Entities Creation")]
    public async Task Create() {
        BatchOperationOutput<YardLog> batchOutput = await _service.Create([
                EntityFactory(),
                EntityFactory(),
                EntityFactory()
            ]);

        Assert.Multiple(
           () => Assert.False(batchOutput.Failed),
           () => Assert.Equal(3, batchOutput.Successes.Length),
           () => Assert.Empty(batchOutput.Failures)
        );

    }

    [Fact(DisplayName = "[Update]: Update an entity")]
    public async Task Update() {
        YardLog changedEntity = SampleYardlog();
        changedEntity.FromTo = "upd_fromto" + changedEntity.FromTo;
        UpdateOutput<YardLog> updateOutput = await _service.Update(new UpdateInput<YardLog> {
            Entity = changedEntity,
            Create = true,
        });

        Assert.Multiple(
            () => Assert.Equal(updateOutput.Original?.Id, updateOutput.Updated.Id),
            () => Assert.NotEqual(updateOutput.Original?.FromTo, updateOutput.Updated.FromTo)
        );

    }

    [Fact(DisplayName = "[Delete]: Correctly deletes an entity")]
    public async Task Delete() {
        YardLog sample = SampleYardlog();

        YardLog deleted = await _service.Delete(sample);

        Assert.Equal(sample.Id, deleted.Id);
        Assert.Equal(sample.FromTo, deleted.FromTo);
    }

    [Fact(DisplayName = "[Delete]: Correctly deletes an entity collection")]
    public async Task DeleteCollection() {
        YardLog sample = SampleYardlog();

        BatchOperationOutput<YardLog> batchOutput = await _service.Delete([
                SampleYardlog(),
                SampleYardlog(),
                SampleYardlog()
            ]);

        Assert.Multiple(
           () => Assert.False(batchOutput.Failed),
           () => Assert.Equal(3, batchOutput.Successes.Length),
           () => Assert.Empty(batchOutput.Failures)
        );
    }
}
