using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business.Depots.Indicators;
using TWS_Business.Entities;
using TWS_Business.Quality.Utils;

using TWS_Customer.Features.Business;

namespace TWS_Customer.Quality.Q_Features.Q_Bussines;
public class Q_StatusesService
    : BQ_Service<IStatusesService> {

    private StatusesDepot? _depot;

    #region [BQ_Service] implementations
    protected override IStatusesService ServiceFactory() {
        TWS_Business.Database businessDatabase = BuildBusinessDb();
        StatusesDepot depot = new StatusesDepot(businessDatabase, Disposer);
        return new StatusesService(depot, businessDatabase);
    }
    #endregion

    [Fact(DisplayName = "[View]: Generates correctly a simple 1 page, 10 range view.")]
    public async Task View() {
        // Create a sample to prevent empty view results.
        Store(BusinessDraftUtils.SampleStatus("tst"));
        ViewOutput<Status> viewOutput = await service.View(
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
        BatchOperationOutput<Status> batchOutput = await service.Create([
                BusinessDraftUtils.SampleStatus("tst"),
                BusinessDraftUtils.SampleStatus("ts2"),
                BusinessDraftUtils.SampleStatus("ts3")
            ]);

        Assert.Multiple(
           () => Assert.False(batchOutput.Failed),
           () => Assert.Equal(3, batchOutput.Successes.Length),
           () => Assert.Empty(batchOutput.Failures)
        );

    }

    [Fact(DisplayName = "[Update]: Update an entity")]
    public async Task Update() {
        Status changedEntity = Store(BusinessDraftUtils.SampleStatus("tst"));
        changedEntity.Name = "updated_name" + changedEntity.Name;
        UpdateOutput<Status> updateOutput = await service.Update(new UpdateInput<Status> {
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
        Status sample = Store(BusinessDraftUtils.SampleStatus("tst"));
        Status deleted = await service.Delete(sample);

        Assert.Equal(sample.Id, deleted.Id);
        Assert.Equal(sample.Name, deleted.Name);
    }

    [Fact(DisplayName = "[Delete]: Correctly deletes an entity collection")]
    public async Task DeleteCollection() {
        Status[] sample = [
                Store(BusinessDraftUtils.SampleStatus("tst")),
                Store(BusinessDraftUtils.SampleStatus("ts1")),
                Store(BusinessDraftUtils.SampleStatus("ts2")),
            ];

        BatchOperationOutput<Status> batchOutput = await service.Delete(sample);

        Assert.Multiple(
           () => Assert.False(batchOutput.Failed),
           () => Assert.Equal(3, batchOutput.Successes.Length),
           () => Assert.Empty(batchOutput.Failures)
        );
    }

    [Fact(DisplayName = "[Read]: Read a record filtering by reference property.")]
    public async Task Read() {
        // Create a sample to prevent empty read results.
        Status status = Store(BusinessDraftUtils.SampleStatus("tst"));
        BatchOperationOutput<Status> batchResult = await service.Read(status.Reference);

        Assert.Multiple(
            () => Assert.True(batchResult.SuccessesCount > 0),
            () => Assert.Equal(0, batchResult.FailuresCount),
            () => Assert.Single(batchResult.Successes)
        );
    }
}

