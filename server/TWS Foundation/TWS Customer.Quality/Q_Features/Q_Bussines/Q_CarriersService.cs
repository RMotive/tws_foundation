using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business.Depots.Vehicles;
using TWS_Business.Entities.Vehicules;

using TWS_Customer.Features.Business;


namespace TWS_Customer.Quality.Q_Features.Q_Bussines;

public class Q_CarriersService
    : BQ_Service<ICarriersService, Carrier> {


    protected override Carrier DraftEntity(string entropy) {
        throw new NotImplementedException();
    }


    [Fact(DisplayName = "[View]: Generates correctly a simple 1 page, 10 range view.")]
    public async Task View() {
        // Create a sample address to prevent empty view results.
        Carrier changedEntity = await _depot!.Store(SampleCarrier(), true);
        ViewOutput<Carrier> viewOutput = await service.View(
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

        BatchOperationOutput<Carrier> batchOutput = await service.Create([
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

    [Fact(DisplayName = "[Update]: Update an entity")]
    public async Task Update() {
        Carrier changedEntity = await _depot!.Store(SampleCarrier(), true);
        changedEntity.Name = "updated_name" + changedEntity.Name;
        UpdateOutput<Carrier> updateOutput = await service.Update(new UpdateInput<Carrier> {
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
        Carrier sample = await _depot!.Store(SampleCarrier(), true);
        Carrier deleted = await service.Delete(sample);

        Assert.Equal(sample.Id, deleted.Id);
        Assert.Equal(sample.Name, deleted.Name);
    }

    [Fact(DisplayName = "[Delete]: Correctly deletes an entity collection")]
    public async Task DeleteCollection() {
        Carrier[] samples = [
            await _depot!.Store(SampleCarrier(), true),
            await _depot!.Store(SampleCarrier(), true),
            await _depot!.Store(SampleCarrier(), true)
            ];

        BatchOperationOutput<Carrier> batchOutput = await service.Delete(samples);

        Assert.Multiple(
           () => Assert.False(batchOutput.Failed),
           () => Assert.Equal(3, batchOutput.Successes.Length),
           () => Assert.Empty(batchOutput.Failures)
        );
    }


}
