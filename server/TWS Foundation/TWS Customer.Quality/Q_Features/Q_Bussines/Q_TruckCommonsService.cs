using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business.Depots.Vehicles;
using TWS_Business.Entities.Vehicules.Trailers;
using TWS_Business.Entities.Vehicules.Trucks;

using TWS_Customer.Features.Business;

namespace TWS_Customer.Quality.Q_Features.Q_Bussines;
public class Q_TruckCommonsService
    : BQ_ServicesCustomer<ITrucksCommonService> {

    #region [BQ_Service] implementations
    protected override ITrucksCommonService ServiceFactory() {
        TWS_Business.Database BussinesDatabase = BusinessDatabaseFactory();

        ITrucksCommonsDepot TrailerClassesDepot = new Trucks_CommonsDepot(BussinesDatabase, Disposer);

        return new TruckCommonsService(TrailerClassesDepot);
    }
    #endregion

    public static List<object[]> testingValues = [[true],[false]];

    #region Private Methods/Functions
    Truck_Common EntityFactory(bool internalValue) {
        Truck_Common common = new Truck_Common {
            Economic = Entropy[..16],
            Status = SampleStatus("tcm"),
            Situation = SampleSituation(),
            Internal = internalValue ? SampleTruck(false) : null,
            External = internalValue ? null : SampleTruckExternal(false),
        };

        return common;
    }
    #endregion

    [Fact(DisplayName = "[View]: Generates correctly a simple 1 page, 10 range view.")]
    public async Task View() {
        // Create a sample to prevent empty view results.
        SampleTruckCommon(true);
        ViewOutput<Truck_Common> viewOutput = await _service.View(
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
    public async Task Create(bool internalValue) {
        BatchOperationOutput<Truck_Common> batchOutput = await _service.Create([
                EntityFactory(internalValue),
                EntityFactory(internalValue),
                EntityFactory(internalValue)
            ]);

        Assert.Multiple(
           () => Assert.False(batchOutput.Failed),
           () => Assert.True(batchOutput.Successes.Length == 3),
           () => Assert.Empty(batchOutput.Failures)
        );

    }

    [Theory(DisplayName = "[Update]: Update an entity")]
    [MemberData(nameof(testingValues))]
    public async Task Update(bool internalValue) {
        Truck_Common changedEntity = SampleTruckCommon(internalValue);
        changedEntity.Economic = "eco_" + changedEntity.Economic;
        UpdateOutput<Truck_Common> updateOutput = await _service.Update(new UpdateInput<Truck_Common> {
            Entity = changedEntity,
            Create = true,
        });

        Assert.Multiple(
            () => Assert.Equal(updateOutput.Original?.Id, updateOutput.Updated.Id),
            () => Assert.NotEqual(updateOutput.Original?.Economic, updateOutput.Updated.Economic)
        );

    }

    
}