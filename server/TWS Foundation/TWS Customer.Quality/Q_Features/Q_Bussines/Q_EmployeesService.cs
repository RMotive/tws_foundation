using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;

using TWS_Business.Depots;
using TWS_Business.Entities;
using TWS_Business.Entities.Employees;

using TWS_Customer.Features.Business;


namespace TWS_Customer.Quality.Q_Features.Q_Bussines;

public class Q_EmployeesService
    : BQ_ServicesCustomer<IEmployeesService> {
    public Q_EmployeesService() {

    }

    #region [BQ_Service] implementations
    protected override IEmployeesService ServiceFactory() {
        TWS_Business.Database BussinesDatabase = BusinessDatabaseFactory();

        IEmployeesDepot EmployeesDepot = new EmployeesDepot(BussinesDatabase, Disposer);

        return new EmployeesService(EmployeesDepot);
    }
    #endregion

    #region Private Methods/Functions
    Employee GenerateMock(string Entropy) {
        DateOnly date = new(2030, 11, 11);

        Status status = Store(
                new Status {
                    Name = Entropy,
                    Description = Entropy,
                }
            );
        Status statusI = Store(
                new Status {
                    Name = "I" + Entropy,
                    Description = Entropy,
                }
            );

        Identification identification = Store(
                 new Identification {
                     Name = Entropy,
                     LastName = Entropy,
                     Status = statusI,
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
            Status = status,
            Identification = identification,
            Dates = employee_Dates,
        };
    }
    #endregion

    [Fact(DisplayName = "[View]: Records view")]
    public async Task View() {
        Store(GenerateMock(RandomUtils.String(16)));
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
}
