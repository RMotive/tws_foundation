using CSM_Foundation.Core.Utils;
using CSM_Foundation.Customer.Quality;
using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business.Depots;
using TWS_Business.Entities;
using TWS_Business.Entities.Trailers;
using TWS_Business.Entities.Vehicules.Trailers;

using TWS_Customer.Features.Business;
using TWS_Customer.Quality.Factories;


namespace TWS_Customer.Quality.Q_Features.Q_Bussines;

public class Q_TrailerTypesService
    : BQ_Service<ITrailerTypesService> {
    public Q_TrailerTypesService()
        : base(
                [
                    DatabaseFactories.BusinessDatabaseFactory,
                ]
            ) {

    }

    #region [BQ_Service] implementations
    protected override ITrailerTypesService ServiceFactory() {
        TWS_Business.Database BussinesDatabase = DatabaseFactories.BusinessDatabaseFactory();

        ITrailerTypesDepot TrailerTypesDepot = new TrailerTypesDepot(BussinesDatabase, Disposer);

        return new TrailerTypesService(TrailerTypesDepot);
    }
    #endregion

    #region Private Methods/Functions
    Trailer_Type GenerateMock(string Entropy) {
        return new Trailer_Type {
            Size = Entropy[..5],
            Status = Store(
                   new Status {
                       Name = Entropy,
                   }
                ),
            Class = Store(
                    new Trailer_Class {
                        Name = Entropy[..10],
                    }
                ),
        };
    }
    #endregion

    [Fact(DisplayName = "[View]: Records view")]
    public async Task View() {
        Store(GenerateMock(RandomUtils.String(16)));
        ViewOutput<Trailer_Type> viewOutput = await _service.View(
                new QueryInput<Trailer_Type, ViewInput<Trailer_Type>> {
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
