using CSM_Foundation.Core.Utils;
using CSM_Foundation.Customer.Quality;
using CSM_Foundation.Database.Entity.Depot;
using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business.Entities;
using TWS_Business.Entities.Trailers;
using TWS_Business.Entities.Vehicules.Trailers;

using TWS_Customer.Features.Business;


namespace TWS_Customer.Quality.Q_Features.Q_Bussines;

public class Q_TrailerTypesService
    : BQ_ServicesCustomer<ITrailerTypesService> {
    public Q_TrailerTypesService() { }

    #region [BQ_Service] implementations
    protected override ITrailerTypesService ServiceFactory() {
        TWS_Business.Database BussinesDatabase = BusinessDatabaseFactory();

        ITrailerTypesDepot TrailerTypesDepot = new TrailerTypesDepot(BussinesDatabase, Disposer);

        return new TrailerTypesService(TrailerTypesDepot);
    }
    #endregion

    #region Private Methods/Functions

    Trailer_Type EntityFactory() {
        return new Trailer_Type {
            Size = Entropy[..5],
            Status = SampleStatus("ttp"),
            Class = SampleTrailerClass(),
        };
    }

    #endregion

    [Fact(DisplayName = "[View]: Generates correctly a simple 1 page, 10 range view.")]
    public async Task View() {
        // Create a sample to prevent empty view results.
        SampleTrailerType();
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

    [Fact(DisplayName = "[Create]: Entities Creation")]
    public async Task Create() {
        BatchOperationOutput<Trailer_Type> batchOutput = await _service.Create([
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
        Trailer_Type changedEntity = SampleTrailerType();
        changedEntity.Size = "upd_size" + changedEntity.Size;
        UpdateOutput<Trailer_Type> updateOutput = await _service.Update(new UpdateInput<Trailer_Type> {
            Entity = changedEntity,
            Create = true,
        });

        Assert.Multiple(
            () => Assert.Equal(updateOutput.Original?.Id, updateOutput.Updated.Id),
            () => Assert.NotEqual(updateOutput.Original?.Size, updateOutput.Updated.Size)
        );

    }

    [Fact(DisplayName = "[Delete]: Correctly deletes an entity")]
    public async Task Delete() {
        Trailer_Type sample = SampleTrailerType();

        Trailer_Type deleted = await _service.Delete(sample);

        Assert.Equal(sample.Id, deleted.Id);
        Assert.Equal(sample.Size, deleted.Size);
    }

    [Fact(DisplayName = "[Delete]: Correctly deletes an entity collection")]
    public async Task DeleteCollection() {
        Trailer_Type sample = SampleTrailerType();

        BatchOperationOutput<Trailer_Type> batchOutput = await _service.Delete([
                SampleTrailerType(),
                SampleTrailerType(),
                SampleTrailerType()
            ]);

        Assert.Multiple(
           () => Assert.False(batchOutput.Failed),
           () => Assert.Equal(3, batchOutput.Successes.Length),
           () => Assert.Empty(batchOutput.Failures)
        );
    }
}
