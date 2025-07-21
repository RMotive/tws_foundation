using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business.Depots;
using TWS_Business.Depots.Indicators;
using TWS_Business.Entities;

using TWS_Customer.Features.Business;

namespace TWS_Customer.Quality.Q_Features.Q_Bussines;
public class Q_SituationsService
    : BQ_ServicesCustomer<ISituationsService> {

    private SituationsDepot? _depot;

    #region [BQ_Service] implementations
    protected override ISituationsService ServiceFactory() {
        TWS_Business.Database BussinesDatabase = BusinessDatabaseFactory();
        _depot = new SituationsDepot(BussinesDatabase, Disposer);
        return new SituationsService(_depot, BussinesDatabase);
    }
    #endregion

    [Fact(DisplayName = "[View]: Generates correctly a simple 1 page, 10 range view.")]
    public async Task View() {
        // Create a sample to prevent empty view results.
        await _depot!.Store(SampleSituation(), true);
        ViewOutput<Situation> viewOutput = await service.View(
                new QueryInput<Situation, ViewInput<Situation>> {
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
        BatchOperationOutput<Situation> batchOutput = await service.Create([
                SampleSituation(),
                SampleSituation(),
                SampleSituation()
            ]);

        Assert.Multiple(
           () => Assert.False(batchOutput.Failed),
           () => Assert.Equal(3, batchOutput.Successes.Length),
           () => Assert.Empty(batchOutput.Failures)
        );

    }

    [Fact(DisplayName = "[Update]: Update an entity")]
    public async Task Update() {
        Situation changedEntity = await _depot!.Store(SampleSituation(), true);
        changedEntity.Name = "updated_name" + changedEntity.Name;
        UpdateOutput<Situation> updateOutput = await service.Update(new UpdateInput<Situation> {
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
        Situation sample = await _depot!.Store(SampleSituation(), true);
        Situation deleted = await service.Delete(sample);

        Assert.Equal(sample.Id, deleted.Id);
        Assert.Equal(sample.Name, deleted.Name);
    }

    [Fact(DisplayName = "[Delete]: Correctly deletes an entity collection")]
    public async Task DeleteCollection() {
        Situation[] sample = [
                await _depot!.Store(SampleSituation(), true),
                await _depot!.Store(SampleSituation(), true),
                await _depot!.Store(SampleSituation(), true),
            ];

        BatchOperationOutput<Situation> batchOutput = await service.Delete(sample);

        Assert.Multiple(
           () => Assert.False(batchOutput.Failed),
           () => Assert.Equal(3, batchOutput.Successes.Length),
           () => Assert.Empty(batchOutput.Failures)
        );
    }
}

