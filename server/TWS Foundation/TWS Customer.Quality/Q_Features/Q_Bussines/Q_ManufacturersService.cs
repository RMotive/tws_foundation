using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business.Depots;
using TWS_Business.Depots.Vehicles;
using TWS_Business.Entities.Vehicules;

using TWS_Customer.Features.Business.Vehicules;

namespace TWS_Customer.Quality.Q_Features.Q_Bussines;
public class Q_ManufacturersService
    : BQ_ServicesCustomer<IManufacturersService> {

    private ManufacturersDepot? _depot;

    #region [BQ_Service] implementations
    protected override IManufacturersService ServiceFactory() {
        TWS_Business.Database BussinesDatabase = BusinessDatabaseFactory();
        _depot = new ManufacturersDepot(BussinesDatabase, Disposer);
        return new ManufacturersService(_depot, BussinesDatabase);
    }
    #endregion

    [Fact(DisplayName = "[View]: Generates correctly a simple 1 page, 10 range view.")]
    public async Task View() {
        // Create a sample to prevent empty view results.
        await _depot!.Store(SampleManufacturer(), true);
        ViewOutput<Manufacturer> viewOutput = await _service.View(
                new QueryInput<Manufacturer, ViewInput<Manufacturer>> {
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
        BatchOperationOutput<Manufacturer> batchOutput = await _service.Create([
                SampleManufacturer(),
                SampleManufacturer(),
                SampleManufacturer()
            ]);

        Assert.Multiple(
           () => Assert.False(batchOutput.Failed),
           () => Assert.Equal(3, batchOutput.Successes.Length),
           () => Assert.Empty(batchOutput.Failures)
        );

    }

    [Fact(DisplayName = "[Update]: Update an entity")]
    public async Task Update() {
        Manufacturer changedEntity = await _depot!.Store(SampleManufacturer(), true);
        changedEntity.Name = "updated_street" + changedEntity.Name;
        UpdateOutput<Manufacturer> updateOutput = await _service.Update(new UpdateInput<Manufacturer> {
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
        Manufacturer sample = await _depot!.Store(SampleManufacturer(), true);
        Manufacturer deleted = await _service.Delete(sample);

        Assert.Equal(sample.Id, deleted.Id);
        Assert.Equal(sample.Name, deleted.Name);
    }

    [Fact(DisplayName = "[Delete]: Correctly deletes an entity collection")]
    public async Task DeleteCollection() {
        Manufacturer[] sample = [
                await _depot!.Store(SampleManufacturer(), true),
                await _depot!.Store(SampleManufacturer(), true),
                await _depot!.Store(SampleManufacturer(), true)
            ];
            
        BatchOperationOutput<Manufacturer> batchOutput = await _service.Delete(sample);

        Assert.Multiple(
           () => Assert.False(batchOutput.Failed),
           () => Assert.Equal(3, batchOutput.Successes.Length),
           () => Assert.Empty(batchOutput.Failures)
        );
    }


}
