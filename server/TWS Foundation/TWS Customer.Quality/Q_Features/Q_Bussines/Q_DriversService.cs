using CSM_Database_Core.Depots.Models;

using CSM_Foundation.Core.Utils;

using TWS_Business.Depots;
using TWS_Business.Entities.Drivers;
using TWS_Business.Quality.Utils;

using TWS_Customer.Features.Business;

namespace TWS_Customer.Quality.Q_Features.Q_Bussines;
public class Q_DriversService
    : BQ_Service<IDriversService, Driver_Common> {

    protected override Driver_Common DraftEntity(string entropy) {
        return BusinessDraftUtils.SampleDriverCommon(true);
    }

    protected override IDriversService ServiceFactory() {
        TWS_Business.Database BussinesDatabase = BuildBusinessDb();
        DriversDepot depot = new(BussinesDatabase, Disposer);
        return new DriversService(depot, BussinesDatabase);
    }

    public static readonly TheoryData<bool> testingValues = [true, false];

    [Fact(DisplayName = "[View]: Generates correctly a simple 1 page, 10 range view.")]
    public async Task View() {
        // Create a sample to prevent empty view results.
        await Store<Driver_Common, Driver, DriverExternal>(BusinessDraftUtils.SampleDriverCommon(true), true);

        ViewOutput<Driver_Common> viewOutput = await service.View(
                new QueryInput<Driver_Common, ViewInput<Driver_Common>> {
                    Parameters = new() {
                        Retroactive = false,
                        Range = 10,
                        Page = 1,
                    },
                    PostProcessor = view => {

                        return view;
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
    public async Task CreateBatch(bool internalValue) {
        BatchOperationOutput<Driver_Common> batchOutput = await service.Create([
               BusinessDraftUtils.SampleDriverCommon(internalValue),
               BusinessDraftUtils. SampleDriverCommon(internalValue),
               BusinessDraftUtils.SampleDriverCommon(internalValue)
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
        Driver_Common changedEntity = await Store<Driver_Common, Driver, DriverExternal>(BusinessDraftUtils.SampleDriverCommon(internalValue), true);
        Driver_Common copy = changedEntity.DeepCopy();
        copy.License = "upd_" + changedEntity.License;
        UpdateOutput<Driver_Common> updateOutput = await service.Update(new UpdateInput<Driver_Common> {
            Entity = copy,
        });

        Assert.Multiple(
            () => Assert.Equal(updateOutput.Original?.Id, updateOutput.Updated.Id),
            () => Assert.NotEqual(updateOutput.Original?.License, updateOutput.Updated.License)
        );

    }


}