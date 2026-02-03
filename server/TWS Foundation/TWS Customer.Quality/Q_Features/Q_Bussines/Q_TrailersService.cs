using CSM_Database_Core.Depots.Models;

using CSM_Foundation.Core.Utils;

using TWS_Business.Entities.Trailers;
using TWS_Business.Entities.Vehicules.Trailers;
using TWS_Business.Quality.Utils;

using TWS_Customer.Features.Business.Vehicules;

namespace TWS_Customer.Quality.Q_Features.Q_Bussines;
public class Q_TrailersService
    : BQ_Service<ITrailersService, Trailer_Common> {

    protected override Trailer_Common DraftEntity(string entropy) {
        return BusinessDraftUtils.SampleTrailerCommon(true);
    }
    protected override ITrailersService ServiceFactory() {
        TWS_Business.Database businessDatabase = BuildBusinessDb();
        TrailersDepot depot = new(businessDatabase, Disposer);
        return new TrailersService(depot, businessDatabase);
    }

    public static readonly TheoryData<bool> testingValues = [true, false];


    [Theory(DisplayName = "[View]: Generates correctly a simple 1 page, 10 range view.")]
    [MemberData(nameof(testingValues))]
    public async Task View(bool internalValue) {
        // Create a sample to prevent empty view results.
        BusinessDraftUtils.SampleTrailerCommon(internalValue);

        ViewOutput<Trailer_Common> viewOutput = await service.View(
                new QueryInput<Trailer_Common, ViewInput<Trailer_Common>> {
                    Parameters = new() {
                        Retroactive = false,
                        Range = 10,
                        Page = 1,
                    }
                }
            );

        Assert.Multiple(
            () => Assert.True(viewOutput.Pages > 0, "There must be more than 0 View Pages"),
            () => Assert.True(viewOutput.Length > 0, "View Entities result can't be empty"),
            () => Assert.Equal(1, viewOutput.Page),
            () => Assert.Equal(viewOutput.Length, viewOutput.Entities.Length)
        );
    }

    [Theory(DisplayName = "[Create]: Entities Creation")]
    [MemberData(nameof(testingValues))]
    public async Task CreateBatch(bool internalValue) {
        BatchOperationOutput<Trailer_Common> batchOutput = await service.Create([
                BusinessDraftUtils.SampleTrailerCommon(internalValue),
                BusinessDraftUtils.SampleTrailerCommon(internalValue),
                BusinessDraftUtils.SampleTrailerCommon(internalValue)
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
        Trailer_Common changedEntity = await Store<Trailer_Common, Trailer, TrailerExternal>(BusinessDraftUtils.SampleTrailerCommon(internalValue), true);
        Trailer_Common copy = changedEntity.DeepCopy();
        copy.Economic = "eco_" + changedEntity.Economic;
        UpdateOutput<Trailer_Common> updateOutput = await service.Update(new UpdateInput<Trailer_Common> {
            Entity = copy,
        });

        Assert.Multiple(
            () => Assert.Equal(updateOutput.Original?.Id, updateOutput.Updated.Id),
            () => Assert.NotEqual(updateOutput.Original?.Economic, updateOutput.Updated.Economic)
        );
    }
}