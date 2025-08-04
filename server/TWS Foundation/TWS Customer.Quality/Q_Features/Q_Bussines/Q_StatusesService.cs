using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business.Depots.Indicators;
using TWS_Business.Entities;

using TWS_Customer.Features.Business;

namespace TWS_Customer.Quality.Q_Features.Q_Bussines;
public class Q_StatusesService
    : BQ_ServicesCustomer<IStatusesService> {

    private StatusesDepot? _depot;

    #region [BQ_Service] implementations
    protected override IStatusesService ServiceFactory() {
        TWS_Business.Database BussinesDatabase = BusinessDatabaseFactory();
        _depot = new StatusesDepot(BussinesDatabase, Disposer);
        return new StatusesService(_depot, BussinesDatabase);
    }
    #endregion

    [Fact(DisplayName = "[View]: Generates correctly a simple 1 page, 10 range view.")]
    public async Task View() {
        // Create a sample to prevent empty view results.
        await _depot!.Store(SampleStatus("tst"), true);
        ViewOutput<Status> viewOutput = await _service.View(
                new QueryInput<Status, ViewInput<Status>> {
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
        BatchOperationOutput<Status> batchOutput = await _service.Create([
                SampleStatus("tst"),
                SampleStatus("ts2"),
                SampleStatus("ts3")
            ]);

        Assert.Multiple(
           () => Assert.False(batchOutput.Failed),
           () => Assert.Equal(3, batchOutput.Successes.Length),
           () => Assert.Empty(batchOutput.Failures)
        );

    }

    [Fact(DisplayName = "[Update]: Update an entity")]
    public async Task Update() {
        Status changedEntity = await _depot!.Store(SampleStatus("tst"), true);
        changedEntity.Name = "updated_name" + changedEntity.Name;
        UpdateOutput<Status> updateOutput = await _service.Update(new UpdateInput<Status> {
            Entity = changedEntity,
            Create = true,
        });

        Assert.Multiple(
            () => Assert.Equal(updateOutput.Original?.Id, updateOutput.Updated.Id),
            () => Assert.NotEqual(updateOutput.Original?.Name, updateOutput.Updated.Name)
        );

    }

    [Fact(DisplayName = "[Delete]: Correctly deletes an entity")]
    public async Task Delete() {
        Status sample = await _depot!.Store(SampleStatus("tst"), true);
        Status deleted = await _service.Delete(sample);

        Assert.Equal(sample.Id, deleted.Id);
        Assert.Equal(sample.Name, deleted.Name);
    }

    [Fact(DisplayName = "[Delete]: Correctly deletes an entity collection")]
    public async Task DeleteCollection() {
        Status[] sample = [
                await _depot!.Store(SampleStatus("tst"), true),
                await _depot!.Store(SampleStatus("ts1"), true),
                await _depot!.Store(SampleStatus("ts2"), true),
            ];

        BatchOperationOutput<Status> batchOutput = await _service.Delete(sample);

        Assert.Multiple(
           () => Assert.False(batchOutput.Failed),
           () => Assert.Equal(3, batchOutput.Successes.Length),
           () => Assert.Empty(batchOutput.Failures)
        );
    }

    [Fact(DisplayName = "[Read]: Read a record filtering by reference property.")]
    public async Task Read() {
        // Create a sample to prevent empty read results.
        Status status = await _depot!.Store(SampleStatus("tst"), true);
        BatchOperationOutput<Status> batchResult = await _service.Read(status.Reference);

        Assert.Multiple(
            () => Assert.True(batchResult.SuccessesCount > 0),
            () => Assert.Equal(0, batchResult.FailuresCount),
            () => Assert.Single(batchResult.Successes)
        );
    }
}

