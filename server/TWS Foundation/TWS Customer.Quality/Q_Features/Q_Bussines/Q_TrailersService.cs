using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business.Depots;
using TWS_Business.Entities.Trailers;
using TWS_Business.Entities.Vehicules.Trailers;

using TWS_Customer.Features.Business;

namespace TWS_Customer.Quality.Q_Features.Q_Bussines;
public class Q_TrailersService
    : BQ_ServicesCustomer<ITrailersService> {

    private TrailersDepot? _depot;

    #region [BQ_Service] implementations
    protected override ITrailersService ServiceFactory() {
        TWS_Business.Database BussinesDatabase = BusinessDatabaseFactory();
        _depot = new TrailersDepot(BussinesDatabase, Disposer);
        return new TrailersService(_depot, BussinesDatabase);
    }
    #endregion

    public static readonly TheoryData<bool> testingValues = [true, false];

    [Fact(DisplayName = "[View]: Generates correctly a simple 1 page, 10 range view.")]
    public async Task View() {
        // Create a sample to prevent empty view results.
        await _depot!.Store(SampleTrailerCommon(true), true);
        ViewOutput<Trailer_Common> viewOutput = await _service.View(
                new QueryInput<Trailer_Common, ViewInput<Trailer_Common>> {
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

    [Theory(DisplayName = "[Create]: Entities Creation")]
    [MemberData(nameof(testingValues))]
    public async Task Create(bool internalValue) {
        BatchOperationOutput<Trailer_Common> batchOutput = await _service.Create([
                SampleTrailerCommon(internalValue),
                SampleTrailerCommon(internalValue),
                SampleTrailerCommon(internalValue)
            ]);

        Assert.Multiple(
           () => Assert.False(batchOutput.Failed),
           () => Assert.Equal(3, batchOutput.Successes.Length),
           () => Assert.Empty(batchOutput.Failures)
        );

    }

    [Theory(DisplayName = "[Update]: Update an entity")]
    [MemberData(nameof(testingValues))]
    public async Task Update(bool internalValue) {
        Trailer_Common changedEntity = await _depot!.Store(SampleTrailerCommon(internalValue), true);
        changedEntity.Economic = "eco_" + changedEntity.Economic;
        UpdateOutput<Trailer_Common> updateOutput = await _service.Update(new UpdateInput<Trailer_Common> {
            Entity = changedEntity,
        });

        Assert.Multiple(
            () => Assert.Equal(updateOutput.Original?.Id, updateOutput.Updated.Id),
            () => Assert.NotEqual(updateOutput.Original?.Economic, updateOutput.Updated.Economic)
        );

    }


}