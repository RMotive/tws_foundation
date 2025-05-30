using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;

using TWS_Business.Entities.Trailers;
using TWS_Business.Entities.Vehicules.Trailers;

using TWS_Customer.Features.Business;


namespace TWS_Customer.Quality.Q_Features.Q_Bussines;

public class Q_TrailerClassesService
    : BQ_ServicesCustomer<ITrailerClassesService> {
    public Q_TrailerClassesService() {

    }

    #region [BQ_Service] implementations
    protected override ITrailerClassesService ServiceFactory() {
        TWS_Business.Database BussinesDatabase = BusinessDatabaseFactory();

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
        ViewOutput<Trailer_Class> viewOutput = await _service.View(
                new QueryInput<Trailer_Class, ViewInput<Trailer_Class>> {
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
}
