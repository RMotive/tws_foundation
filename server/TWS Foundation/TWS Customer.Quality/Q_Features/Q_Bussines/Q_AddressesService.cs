using CSM_Foundation.Core.Utils;
using CSM_Foundation.Customer.Quality;
using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business.Depots;
using TWS_Business.Entities;

using TWS_Customer.Features.Business;
using TWS_Customer.Quality.Factories;


namespace TWS_Customer.Quality.Q_Features.Q_Bussines;

public class Q_AddressesService
    : BQ_Service<IAddressesService> {
    public Q_AddressesService()
        : base(
                [
                    DatabaseFactories.BusinessDatabaseFactory,
                ]
            ) {

    }

    #region [BQ_Service] implementations
    protected override IAddressesService ServiceFactory() {
        TWS_Business.Database BussinesDatabase = DatabaseFactories.BusinessDatabaseFactory();

        IAddressesDepot AddressesDepot = new AddressesDepot(BussinesDatabase, Disposer);

        return new AddressesService(AddressesDepot);
    }
    #endregion

    #region Private Methods/Functions
    Address GenerateMock(string Entropy) {
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

    [Fact(DisplayName = "[View]: Records view")]
    public async Task View() {
        Store(GenerateMock(RandomUtils.String(16)));
        ViewOutput<Address> viewOutput = await _service.View(
                new OperationInput<Address, ViewInput<Address>> {
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

    [Fact(DisplayName = "[Read]: Reads matched records")]
    public async Task Read() {
        Address mock = Store(GenerateMock(RandomUtils.String(16)));
        BatchOperationOutput<Address> readOutput = await _service.Read(EntityBatchBehaviors.First, location => location.Id == mock.Id);

        Assert.Multiple(
            () => Assert.False(readOutput.Failed),
            () => Assert.True(readOutput.Successes.First().Id > 0)
        );
    }
}
