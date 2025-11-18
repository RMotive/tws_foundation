using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business.Depots.Vehicles;
using TWS_Business.Entities.Vehicules.Trucks;
using TWS_Business.Quality.Utils;

using TWS_Customer.Features.Business;

namespace TWS_Customer.Quality.Q_Features.Q_Bussines;
public class Q_TrucksService
    : BQ_Service<ITrucksService, Truck_Common> {

    protected override Truck_Common DraftEntity(string entropy) {
        return BusinessDraftUtils.SampleTruckCommon(true);
    }
    protected override ITrucksService ServiceFactory() {
        TWS_Business.Database businessDatabase = BuildBusinessDb();
        TrucksDepot depot = new(businessDatabase, Disposer);
        return new TrucksService(depot, businessDatabase);
    }


    public static readonly TheoryData<bool> testingValues = [true, false];

    [Fact(DisplayName = "[View]: Generates correctly a simple 1 page, 10 range view.")]
    public async Task View() {
        // Create a sample to prevent empty view results.
        await Store<Truck_Common, Truck, TruckExternal>(BusinessDraftUtils.SampleTruckCommon(true), true);
        ViewOutput<Truck_Common> viewOutput = await service.View(
                new QueryInput<Truck_Common, ViewInput<Truck_Common>> {
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
    public async Task CreateBatch(bool internalValue) {
        BatchOperationOutput<Truck_Common> batchOutput = await service.Create([
                BusinessDraftUtils.SampleTruckCommon(internalValue),
                BusinessDraftUtils.SampleTruckCommon(internalValue),
                BusinessDraftUtils.SampleTruckCommon(internalValue)
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
        Truck_Common changedEntity = await Store<Truck_Common, Truck, TruckExternal>(BusinessDraftUtils.SampleTruckCommon(internalValue), true);
        Truck_Common copy = changedEntity.DeepCopy();
        copy.Economic = "eco_" + changedEntity.Economic;
        UpdateOutput<Truck_Common> updateOutput = await service.Update(new UpdateInput<Truck_Common> {
            Entity = copy,
        });

        Assert.Multiple(
            () => Assert.Equal(updateOutput.Original?.Id, updateOutput.Updated.Id),
            () => Assert.NotEqual(updateOutput.Original?.Economic, updateOutput.Updated.Economic)
        );
    }

}