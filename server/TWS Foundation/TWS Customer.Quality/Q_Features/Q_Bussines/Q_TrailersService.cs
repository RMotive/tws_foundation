using CSM_Foundation.Core.Utils;
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
    : BQ_Service<ITrailersService, Trailer_Common> {

    protected override Trailer_Common DraftEntity(string entropy) {
        throw new NotImplementedException();
    }

    public static readonly TheoryData<bool> testingValues = [true, false];

    #region Private Methods/Functions
    Trailer_Common EntityFactory(bool internalValue) {
        Trailer_Common common = new() {
            Economic = Entropy[..16],
            Status = SampleStatus("tcm"),
            Situation = SampleSituation(),
            Internal = internalValue ? null : null,
            External = internalValue ? null : null,
        };
        return common;
    }
    #endregion

    [Theory(DisplayName = "[View]: Generates correctly a simple 1 page, 10 range view.")]
    [MemberData(nameof(testingValues))]
    public async Task View(bool internalValue) {
        // Create a sample to prevent empty view results.
        SampleTrailerCommon(internalValue);

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
            () => Assert.True(viewOutput.Pages > 0, "There must be more than 0 View Pages"),
            () => Assert.True(viewOutput.Length > 0, "View Entities result can't be empty"),
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
        Trailer_Common copy = changedEntity.DeepCopy();
        copy.Economic = "eco_" + changedEntity.Economic;
        UpdateOutput<Trailer_Common> updateOutput = await _service.Update(new UpdateInput<Trailer_Common> {
            Entity = copy,
        });

        Assert.Multiple(
            () => Assert.Equal(updateOutput.Original?.Id, updateOutput.Updated.Id),
            () => Assert.NotEqual(updateOutput.Original?.Economic, updateOutput.Updated.Economic)
        );

    protected override ITrailersService ServiceFactory() {
        throw new NotImplementedException();
    }
}