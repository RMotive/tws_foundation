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

    #region [BQ_Service] implementations
    protected override IAddressesService ServiceFactory() {
        TWS_Business.Database BussinesDatabase = BusinessDatabaseFactory();

        IAddressesDepot AddressesDepot = new AddressesDepot(BussinesDatabase, Disposer);

        return new AddressesService(AddressesDepot);
    }
    #endregion


    #region Private Methods/Functions
    Address EntityFactory() {
        return new Address {
            State = Entropy[..3],
            Street = Entropy,
            AltStreet = Entropy,
            City = Entropy,
            ZIP = Entropy[..5],
            Country = Entropy[..3],
            Subdivision = Entropy,
        };
    }
    #endregion

    [Fact(DisplayName = "[View]: Generates correctly a simple 1 page, 10 range view.")]
    public async Task View() {
        // Create a sample address to prevent empty view results.
        SampleAddress();
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
                EntityFactory(),
                EntityFactory(),
                EntityFactory()
            ]);

        Assert.Multiple(
           () => Assert.False(batchOutput.Failed),
           () => Assert.True(batchOutput.Successes.Length == 3),
           () => Assert.Empty(batchOutput.Failures)
        );

    }

    [Fact(DisplayName = "[Update]: Update an entity")]
    public async Task Update() {
        Address changedEntity = SampleAddress();
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
        Address sample = SampleAddress();

        Address deleted = await _service.Delete(sample.Id);

        Assert.Equal(sample.Id, deleted.Id);
        Assert.Equal(sample.Street, deleted.Street);
        Assert.Equal(sample.Country, deleted.Country);
    }

    [Fact(DisplayName = "[Delete]: Correctly deletes an entity collection")]
    public async Task DeleteCollection() {
        Address sample = SampleAddress();

        BatchOperationOutput<Address> batchOutput = await _service.Delete([
                SampleAddress().Id,
                SampleAddress().Id,
                SampleAddress().Id
            ]);

        Assert.Multiple(
           () => Assert.False(batchOutput.Failed),
           () => Assert.True(batchOutput.Successes.Length == 3),
           () => Assert.Empty(batchOutput.Failures)
        );
    }
}
