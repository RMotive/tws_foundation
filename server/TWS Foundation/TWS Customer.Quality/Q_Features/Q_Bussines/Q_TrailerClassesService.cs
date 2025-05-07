using CSM_Foundation.Core.Utils;
using CSM_Foundation.Customer.Quality;
using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business.Depots;
using TWS_Business.Entities.Vehicules.Trailers;

using TWS_Customer.Features.Business;
using TWS_Customer.Quality.Factories;


namespace TWS_Customer.Quality.Q_Features.Q_Bussines;

public class Q_TrailerClassesService
    : BQ_Service<ITrailerClassesService> {
    public Q_TrailerClassesService()
        : base(
                [
                    DatabaseFactories.BusinessDatabaseFactory,
                ]
            ) {

    }

    #region [BQ_Service] implementations
    protected override ITrailerClassesService ServiceFactory() {
        TWS_Business.Database BussinesDatabase = DatabaseFactories.BusinessDatabaseFactory();

        ITrailerClassesDepot TrailerClassesDepot = new TrailerClassesDepot(BussinesDatabase, Disposer);

        return new TrailerClassesService(TrailerClassesDepot);
    }
    #endregion

    #region Private Methods/Functions
    Trailer_Class GenerateMock(string Entropy) {
        return new Trailer_Class {
            Name = Entropy[..10],
        };
    }
    #endregion

    [Fact(DisplayName = "[View]: Records view")]
    public async Task View() {
        Store(GenerateMock(RandomUtils.String(16)));
        SetViewOutput<Trailer_Class> viewOutput = await _service.View(
                new OperationInput<Trailer_Class, SetViewInput<Trailer_Class>> {
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
        Trailer_Class mock = Store(GenerateMock(RandomUtils.String(16)));
        BatchOperationOutput<Trailer_Class, Trailer_Class> readOutput = await _service.Read(EntityBatchBehaviors.First, location => location.Id == mock.Id);

        Assert.Multiple(
            () => Assert.False(readOutput.Failed),
            () => Assert.True(readOutput.Successes.First().Id > 0)
        );
    }
}
