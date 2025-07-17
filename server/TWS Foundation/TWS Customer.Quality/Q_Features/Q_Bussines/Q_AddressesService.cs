using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business.Depots;
using TWS_Business.Entities;

using TWS_Customer.Features.Business;


namespace TWS_Customer.Quality.Q_Features.Q_Bussines;

public class Q_AddressesService
    : BQ_ServicesCustomer<IAddressesService> {

    private AddressesDepot? _depot;

    #region [BQ_Service] implementations
    protected override IAddressesService ServiceFactory() {
        TWS_Business.Database BussinesDatabase = BusinessDatabaseFactory();
        _depot = new AddressesDepot(BussinesDatabase, Disposer);
        IAddressesDepot AddressesDepot = new AddressesDepot(BussinesDatabase, Disposer);
        return new AddressesService(AddressesDepot);
    }
    #endregion


    [Fact(DisplayName = "[View]: Generates correctly a simple 1 page, 10 range view.")]
    public async Task View() {
        // Create a sample address to prevent empty view results.
        Address address = await _depot!.Store(SampleAddress(), true);

        ViewOutput<Address> viewOutput = await _service.View(
                new QueryInput<Address, ViewInput<Address>> {
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
        BatchOperationOutput<Address> batchOutput = await _service.Create([
                SampleAddress(),
                SampleAddress(),
                SampleAddress()
            ]);

        Assert.Multiple(
           () => Assert.False(batchOutput.Failed),
           () => Assert.Equal(3, batchOutput.Successes.Length),
           () => Assert.Empty(batchOutput.Failures)
        );

    }

    [Fact(DisplayName = "[Update]: Update an entity")]
    public async Task Update() {
        Address changedEntity = await _depot!.Store(SampleAddress(), true);
        changedEntity.Street = "updated_street" + changedEntity.Street;
        UpdateOutput<Address> updateOutput = await _service.Update(new UpdateInput<Address> {
            Entity = changedEntity,
            Create = true,
        });

        Assert.Multiple(
            () => Assert.Equal(updateOutput.Original?.Id, updateOutput.Updated.Id),
            () => Assert.NotEqual(updateOutput.Original?.Street, updateOutput.Updated.Street)
        );

    }

    [Fact(DisplayName = "[Delete]: Correctly deletes an entity")]
    public async Task Delete() {
        Address sample = await _depot!.Store(SampleAddress(), true);

        Address deleted = await _service.Delete(sample);

        Assert.Equal(sample.Id, deleted.Id);
        Assert.Equal(sample.Street, deleted.Street);
        Assert.Equal(sample.Country, deleted.Country);
    }

    [Fact(DisplayName = "[Delete]: Correctly deletes an entity collection")]
    public async Task DeleteCollection() {
        Address[] samples = [
            await _depot!.Store(SampleAddress(), true),
            await _depot!.Store(SampleAddress(), true),
            await _depot!.Store(SampleAddress(), true)
            ];

        BatchOperationOutput<Address> batchOutput = await _service.Delete(samples);

        Assert.Multiple(
           () => Assert.False(batchOutput.Failed),
           () => Assert.Equal(3, batchOutput.Successes.Length),
           () => Assert.Empty(batchOutput.Failures)
        );
    }
}
