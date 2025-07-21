using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

using Microsoft.AspNetCore.Http;

using TWS_Business.Depots;
using TWS_Business.Entities.Employees;

using TWS_Customer.Features.Business;
using TWS_Customer.Managers.Auth;


namespace TWS_Customer.Quality.Q_Features.Q_Bussines;

public class Q_EmployeesService
    : BQ_ServicesCustomer<IEmployeesService> {

    private EmployeesDepot? _depot;

    #region [BQ_Service] implementations
    protected override IEmployeesService ServiceFactory() {
        TWS_Business.Database businessDatabase = BusinessDatabaseFactory();

        IAuthManager authManager = new AuthManager(
                new HttpContextAccessor {
                    HttpContext = new DefaultHttpContext()
                }
            );

       _depot = new EmployeesDepot(businessDatabase, Disposer);

        return new EmployeesService(_depot, authManager, businessDatabase);
    }
    #endregion

    [Fact(DisplayName = "[View]: Generates correctly a simple 1 page, 10 range view.")]
    public async Task View() {
        // Create a sample to prevent empty view results.
        await _depot!.Store(SampleEmployee(), true);
        ViewOutput<Employee> viewOutput = await service.View(
                new QueryInput<Employee, ViewInput<Employee>> {
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
        BatchOperationOutput<Employee> batchOutput = await service.Create([
                SampleEmployee(),
                SampleEmployee(),
                SampleEmployee()
            ]);

        Assert.Multiple(
           () => Assert.False(batchOutput.Failed),
           () => Assert.Equal(3, batchOutput.Successes.Length),
           () => Assert.Empty(batchOutput.Failures)
        );

    }

    [Fact(DisplayName = "[Update]: Update an entity")]
    public async Task Update() {
        Employee changedEntity = await _depot!.Store(SampleEmployee(), true);
        changedEntity.RFC = "updated_RFC" + Entropy[..2];
        UpdateOutput<Employee> updateOutput = await service.Update(new UpdateInput<Employee> {
            Entity = changedEntity,
            Create = true,
        });

        Assert.Multiple(
            () => Assert.Equal(updateOutput.Original?.Id, updateOutput.Updated.Id),
            () => Assert.NotEqual(updateOutput.Original?.RFC, updateOutput.Updated.RFC)
        );

    }

    [Fact(DisplayName = "[Delete]: Correctly deletes an entity")]
    public async Task Delete() {
        Employee sample = await _depot!.Store(SampleEmployee(), true);
        Employee deleted = await service.Delete(sample);

        Assert.Equal(sample.Id, deleted.Id);
        Assert.Equal(sample.RFC, deleted.RFC);
        Assert.Equal(sample.NSS, deleted.NSS);
    }

    [Fact(DisplayName = "[Delete]: Correctly deletes an entity collection")]
    public async Task DeleteCollection() {
        Employee[] samples = [
           await _depot!.Store(SampleEmployee(), true),
            await _depot!.Store(SampleEmployee(), true),
            await _depot!.Store(SampleEmployee(), true)
           ];

        BatchOperationOutput<Employee> batchOutput = await service.Delete(samples);

        Assert.Multiple(
           () => Assert.False(batchOutput.Failed),
           () => Assert.Equal(3, batchOutput.Successes.Length),
           () => Assert.Empty(batchOutput.Failures)
        );
    }
}
