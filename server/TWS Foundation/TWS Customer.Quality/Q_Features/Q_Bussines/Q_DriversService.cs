using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business.Depots;
using TWS_Business.Entities.Drivers;

using TWS_Customer.Features.Business;

namespace TWS_Customer.Quality.Q_Features.Q_Bussines;
public class Q_DriversService
    : BQ_ServicesCustomer<IDriversCommonService> {

    private DriversDepot? _depot;

    #region [BQ_Service] implementations
    protected override IDriversCommonService ServiceFactory() {
        TWS_Business.Database BussinesDatabase = BusinessDatabaseFactory();
        _depot = new DriversDepot(BussinesDatabase, Disposer);
        return new DriversService(_depot, BussinesDatabase);
    }
    #endregion

    public static readonly TheoryData<bool> testingValues = [true, false];

    [Fact(DisplayName = "[View]: Generates correctly a simple 1 page, 10 range view.")]
    public async Task View() {
        // Create a sample to prevent empty view results.
        await _depot!.Store(SampleDriverCommon(true), true);

        ViewOutput<Driver_Common> viewOutput = await _service.View(
                new QueryInput<Driver_Common, ViewInput<Driver_Common>> {
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
        BatchOperationOutput<Driver_Common> batchOutput = await _service.Create([
                SampleDriverCommon(internalValue),
                SampleDriverCommon(internalValue),
                SampleDriverCommon(internalValue)
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
        Driver_Common changedEntity = await _depot!.Store(SampleDriverCommon(internalValue), true);

        changedEntity.License = "lic_" + changedEntity.License;
        UpdateOutput<Driver_Common> updateOutput = await _service.Update(new UpdateInput<Driver_Common> {
            Entity = changedEntity,
        });

        Assert.Multiple(
            () => Assert.Equal(updateOutput.Original?.Id, updateOutput.Updated.Id),
            () => Assert.NotEqual(updateOutput.Original?.License, updateOutput.Updated.License)
        );

    }


}