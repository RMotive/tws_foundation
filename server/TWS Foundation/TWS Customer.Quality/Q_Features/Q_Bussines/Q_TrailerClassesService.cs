using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business.Entities.Trailers;
using TWS_Business.Entities.Vehicules.Trailers;

using TWS_Customer.Features.Business;


namespace TWS_Customer.Quality.Q_Features.Q_Bussines;

public class Q_TrailerClassesService
    : BQ_ServicesCustomer<ITrailerClassesService> {

    #region [BQ_Service] implementations
    protected override ITrailerClassesService ServiceFactory() {
        TWS_Business.Database BussinesDatabase = BusinessDatabaseFactory();

        ITrailerClassesDepot TrailerClassesDepot = new TrailerClassesDepot(BussinesDatabase, Disposer);

        return new TrailerClassesService(TrailerClassesDepot);
    }
    #endregion

    #region Private Methods/Functions
    Trailer_Class EntityFactory() {
        return new Trailer_Class {
            Name = Entropy[..10],
        };
    }
    #endregion

    [Fact(DisplayName = "[View]: Generates correctly a simple 1 page, 10 range view.")]
    public async Task View() {
        // Create a sample to prevent empty view results.
        SampleTrailerClass();
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

    [Fact(DisplayName = "[Create]: Entities Creation")]
    public async Task Create() {
        BatchOperationOutput<Trailer_Class> batchOutput = await _service.Create([
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
        Trailer_Class changedEntity = SampleTrailerClass();
        changedEntity.Name = "updated_name" + changedEntity.Name;
        UpdateOutput<Trailer_Class> updateOutput = await _service.Update(new UpdateInput<Trailer_Class> {
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
        Trailer_Class sample = SampleTrailerClass();

        Trailer_Class deleted = await _service.Delete(sample.Id);

        Assert.Equal(sample.Id, deleted.Id);
        Assert.Equal(sample.Name, deleted.Name);
    }

    [Fact(DisplayName = "[Delete]: Correctly deletes an entity collection")]
    public async Task DeleteCollection() {
        Trailer_Class sample = SampleTrailerClass();

        BatchOperationOutput<Trailer_Class> batchOutput = await _service.Delete([
                SampleTrailerClass().Id,
                SampleTrailerClass().Id,
                SampleTrailerClass().Id
            ]);

        Assert.Multiple(
           () => Assert.False(batchOutput.Failed),
           () => Assert.True(batchOutput.Successes.Length == 3),
           () => Assert.Empty(batchOutput.Failures)
        );
    }
}
