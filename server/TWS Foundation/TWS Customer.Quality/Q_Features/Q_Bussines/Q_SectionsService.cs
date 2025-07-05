using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business.Depots.Directories;
using TWS_Business.Entities;

using TWS_Customer.Features.Business;


namespace TWS_Customer.Quality.Q_Features.Q_Bussines;

public class Q_SectionsService
    : BQ_ServicesCustomer<ISectionsService> {

    private SectionsDepot? _depot;

    #region [BQ_Service] implementations
    protected override ISectionsService ServiceFactory() {
        TWS_Business.Database BussinesDatabase = BusinessDatabaseFactory();
        _depot = new SectionsDepot(BussinesDatabase, Disposer);
        return new SectionsService(_depot, BussinesDatabase);
    }
    #endregion

    [Fact(DisplayName = "[View]: Generates correctly a simple 1 page, 10 range view.")]
    public async Task View() {
        // Create a sample address to prevent empty view results.
        await _depot!.Store(SampleSection(), true);
        ViewOutput<Section> viewOutput = await _service.View(
                new QueryInput<Section, ViewInput<Section>> {
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
        BatchOperationOutput<Section> batchOutput = await _service.Create([
                SampleSection(),
                SampleSection(),
                SampleSection(),
            ]);

        Assert.Multiple(
           () => Assert.False(batchOutput.Failed),
           () => Assert.Equal(3, batchOutput.Successes.Length),
           () => Assert.Empty(batchOutput.Failures)
        );

    }

    [Fact(DisplayName = "[Update]: Update an entity")]
    public async Task Update() {
        Section changedEntity = await _depot!.Store(SampleSection(), true);
        changedEntity.Name = "updated_name" + changedEntity.Name;
        UpdateOutput<Section> updateOutput = await _service.Update(new UpdateInput<Section> {
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
        Section sample = await _depot!.Store(SampleSection(), true);
        Section deleted = await _service.Delete(sample);

        Assert.Equal(sample.Id, deleted.Id);
        Assert.Equal(sample.Name, deleted.Name);
        Assert.Equal(sample.Timestamp, deleted.Timestamp);
    }

    [Fact(DisplayName = "[Delete]: Correctly deletes an entity collection")]
    public async Task DeleteCollection() {
        Section[] sample = [
                await _depot!.Store(SampleSection(), true),
                await _depot!.Store(SampleSection(), true), 
                await _depot!.Store(SampleSection(), true)
            ];

        BatchOperationOutput<Section> batchOutput = await _service.Delete(sample);

        Assert.Multiple(
           () => Assert.False(batchOutput.Failed),
           () => Assert.Equal(3, batchOutput.Successes.Length),
           () => Assert.Empty(batchOutput.Failures)
        );
    }

}
