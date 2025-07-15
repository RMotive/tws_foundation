using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business.Depots.Vehicles;
using TWS_Business.Entities.Vehicules;

using TWS_Customer.Features.Business.Vehicules;

namespace TWS_Customer.Quality.Q_Features.Q_Bussines;
public class Q_VehiculeModelsService
    : BQ_ServicesCustomer<IVehiculeModelsService> {

    #region [BQ_Service] implementations
    protected override IVehiculeModelsService ServiceFactory() {
        TWS_Business.Database BussinesDatabase = BusinessDatabaseFactory();

        IVehiculesModelsDepot VehiculeModelsDepot = new VehiculeModelsDepot(BussinesDatabase, Disposer);

        return new VehiculeModelsService(VehiculeModelsDepot);
    }
    #endregion

    #region Private Methods/Functions
    VehiculeModel EntityFactory() {
        return new VehiculeModel {
            Name = Entropy[..10],
            Year = DateOnly.FromDateTime(DateTime.Now),
            Status = SampleStatus("vmo"),
            Manufacturer = SampleManufacturer(),
        };
    }
    #endregion

    [Fact(DisplayName = "[View]: Generates correctly a simple 1 page, 10 range view.")]
    public async Task View() {
        // Create a sample to prevent empty view results.
        SampleVehiculeModel();
        ViewOutput<VehiculeModel> viewOutput = await _service.View(
                new QueryInput<VehiculeModel, ViewInput<VehiculeModel>> {
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
        BatchOperationOutput<VehiculeModel> batchOutput = await _service.Create([
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
        VehiculeModel changedEntity = SampleVehiculeModel();
        changedEntity.Name = "updated_name" + changedEntity.Name;
        UpdateOutput<VehiculeModel> updateOutput = await _service.Update(new UpdateInput<VehiculeModel> {
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
        VehiculeModel sample = SampleVehiculeModel();

        VehiculeModel deleted = await _service.Delete(sample);

        Assert.Equal(sample.Id, deleted.Id);
        Assert.Equal(sample.Name, deleted.Name);
    }

    [Fact(DisplayName = "[Delete]: Correctly deletes an entity collection")]
    public async Task DeleteCollection() {
        VehiculeModel sample = SampleVehiculeModel();

        BatchOperationOutput<VehiculeModel> batchOutput = await _service.Delete([
                SampleVehiculeModel(),
                SampleVehiculeModel(),
                SampleVehiculeModel()
            ]);

        Assert.Multiple(
           () => Assert.False(batchOutput.Failed),
           () => Assert.Equal(3, batchOutput.Successes.Length),
           () => Assert.Empty(batchOutput.Failures)
        );
    }


}

