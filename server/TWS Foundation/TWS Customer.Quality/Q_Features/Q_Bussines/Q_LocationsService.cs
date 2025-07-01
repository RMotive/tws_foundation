using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business.Depots;
using TWS_Business.Entities;

using TWS_Customer.Features.Business;

using Location = TWS_Business.Entities.Location;

namespace TWS_Customer.Quality.Q_Features.Q_Bussines;

public class Q_LocationsService
    : BQ_ServicesCustomer<ILocationsService> {

    public Q_LocationsService() {

    }

    #region [BQ_Service] implementations
    protected override ILocationsService ServiceFactory() {
        TWS_Business.Database BussinesDatabase = BusinessDatabaseFactory();

        ILocationsDepot LocationsDepot = new LocationsDepot(BussinesDatabase, Disposer);

        return new LocationsService(LocationsDepot);
    }
    #endregion

    #region Private Methods/Functions
    Location EntityFactory() {
        return new Location {
            Name = Entropy,
            Status = SampleStatus("loc"),
            Address = SampleAddress()
        };
    }
    #endregion

    [Fact(DisplayName = "[View]: Generates correctly a simple 1 page, 10 range view.")]
    public async Task View() {
        // Create a sample = to prevent empty view results.
        SampleLocation();
        ViewOutput<Location> viewOutput = await _service.View(
                new QueryInput<Location, ViewInput<Location>> {
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
        BatchOperationOutput<Location> batchOutput = await _service.Create([
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
        Location changedEntity = SampleLocation();
        changedEntity.Name = "updated_name" + changedEntity.Name;
        UpdateOutput<Location> updateOutput = await _service.Update(new UpdateInput<Location> {
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
        Location sample = SampleLocation();

        Location deleted = await _service.Delete(sample);

        Assert.Equal(sample.Id, deleted.Id);
        Assert.Equal(sample.Name, deleted.Name);
    }

    [Fact(DisplayName = "[Delete]: Correctly deletes an entity collection")]
    public async Task DeleteCollection() {
        Location sample = SampleLocation();

        BatchOperationOutput<Location> batchOutput = await _service.Delete([
                SampleLocation(),
                SampleLocation(),
                SampleLocation()
            ]);

        Assert.Multiple(
           () => Assert.False(batchOutput.Failed),
           () => Assert.Equal(3, batchOutput.Successes.Length),
           () => Assert.Empty(batchOutput.Failures)
        );
    }
}
