using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business.Depots.Vehicles;
using TWS_Business.Entities;
using TWS_Business.Entities.Vehicules;

using TWS_Customer.Features.Business;


namespace TWS_Customer.Quality.Q_Features.Q_Bussines;

public class Q_CarriersService
    : BQ_ServicesCustomer<ICarriersService> {

    #region [BQ_Service] implementations
    protected override ICarriersService ServiceFactory() {
        TWS_Business.Database BussinesDatabase = BusinessDatabaseFactory();

        ICarriersDepot CarrierDepot = new CarriersDepot(BussinesDatabase, Disposer);

        return new CarriersService(CarrierDepot);
    }
    #endregion

    #region Private Methods/Functions
    Carrier EntityFactory() {
        Approach approach = Store(
                new Approach {
                    EMail = $" email_{Entropy}",
                    Status = SampleStatus("apc")
                }
            );

        return new Carrier {
            Name = $"carrier_{Entropy}",
            Status = SampleStatus("car"),
            Address = SampleAddress(),
            Approach = approach,
        };
    }
    #endregion

    [Fact(DisplayName = "[View]: Generates correctly a simple 1 page, 10 range view.")]
    public async Task View() {
        // Create a sample address to prevent empty view results.
        SampleTrailerClass();
        ViewOutput<Carrier> viewOutput = await _service.View(
                new QueryInput<Carrier, ViewInput<Carrier>> {
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
        BatchOperationOutput<Carrier> batchOutput = await _service.Create([
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
        Carrier changedEntity = SampleCarrier();
        changedEntity.Name = "updated_name" + changedEntity.Name;
        UpdateOutput<Carrier> updateOutput = await _service.Update(new UpdateInput<Carrier> {
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
        Carrier sample = SampleCarrier();

        Carrier deleted = await _service.Delete(sample);

        Assert.Equal(sample.Id, deleted.Id);
        Assert.Equal(sample.Name, deleted.Name);
    }

    [Fact(DisplayName = "[Delete]: Correctly deletes an entity collection")]
    public async Task DeleteCollection() {
        Carrier sample = SampleCarrier();

        BatchOperationOutput<Carrier> batchOutput = await _service.Delete([
                SampleCarrier(),
                SampleCarrier(),
                SampleCarrier()
            ]);

        Assert.Multiple(
           () => Assert.False(batchOutput.Failed),
           () => Assert.Equal(3, batchOutput.Successes.Length),
           () => Assert.Empty(batchOutput.Failures)
        );
    }


}
