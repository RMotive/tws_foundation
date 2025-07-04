using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

using Microsoft.AspNetCore.Http;

using TWS_Business.Depots;
using TWS_Business.Entities;
using TWS_Business.Entities.Employees;

using TWS_Customer.Features.Business;
using TWS_Customer.Managers.Auth;


namespace TWS_Customer.Quality.Q_Features.Q_Bussines;

public class Q_EmployeesService
    : BQ_ServicesCustomer<IEmployeesService> {
    public Q_EmployeesService() {

    }

    #region [BQ_Service] implementations
    protected override IEmployeesService ServiceFactory() {
        TWS_Business.Database businessDatabase = BusinessDatabaseFactory();

        IAuthManager authManager = new AuthManager(
                new HttpContextAccessor {
                    HttpContext = new DefaultHttpContext()
                }
            );

        IEmployeesDepot employeesDepot = new EmployeesDepot(businessDatabase, Disposer);

        return new EmployeesService(employeesDepot, authManager);
    }
    #endregion

    #region Private Methods/Functions
    Employee EntityFactory() {
        DateOnly date = new(2030, 11, 11);

        Identification identification = Store(
                 new Identification {
                     Name = Entropy,
                     LastName = Entropy,
                     Status = SampleStatus("ide"),
                 }
            );

        Employee_Dates employee_Dates = Store(
                new Employee_Dates {
                    CNAP = date,
                    IMSS = date,
                    Hire = date,
                    Termination = date,
                }
            );

        return new Employee {
            CURP = Entropy + Entropy[..2],
            RFC = Entropy[..13],
            NSS = Entropy[..11],
            Status = SampleStatus("emp"),
            Identification = identification,
            Dates = employee_Dates,
        };
    }
    #endregion

    [Fact(DisplayName = "[View]: Generates correctly a simple 1 page, 10 range view.")]
    public async Task View() {
        // Create a sample to prevent empty view results.
        SampleEmployee();
        ViewOutput<Employee> viewOutput = await _service.View(
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
        BatchOperationOutput<Employee> batchOutput = await _service.Create([
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
        Employee changedEntity = SampleEmployee();
        changedEntity.RFC = "updated_RFC" + Entropy[..2];
        UpdateOutput<Employee> updateOutput = await _service.Update(new UpdateInput<Employee> {
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
        Employee sample = SampleEmployee();

        Employee deleted = await _service.Delete(sample);

        Assert.Equal(sample.Id, deleted.Id);
        Assert.Equal(sample.RFC, deleted.RFC);
        Assert.Equal(sample.NSS, deleted.NSS);
    }

    [Fact(DisplayName = "[Delete]: Correctly deletes an entity collection")]
    public async Task DeleteCollection() {
        Employee sample = SampleEmployee();

        BatchOperationOutput<Employee> batchOutput = await _service.Delete([
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
}
