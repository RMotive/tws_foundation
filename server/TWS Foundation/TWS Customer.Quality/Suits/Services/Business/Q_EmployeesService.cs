using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Models.Out;

using TWS_Business;
using TWS_Business.Entities;
using TWS_Business.Entities.Employees;

using TWS_Customer.Services.Business.Employees;

namespace TWS_Customer.Quality.Suits.Services.Business;


public class Q_EmployeesService
    : BQ_Service<Employee, EmployeesService, Database> {
    public Q_EmployeesService()
        : base(
                new(new EmployeesDepot()),
                () => new Database()
            ) {

    }

    Employee EmployeeFactory(string? Entropy = null) {
        Entropy ??= RandomUtils.String(16);

        Identification identification = Store(
                new Identification {
                    Name = $"Identification {Entropy}",
                    Lastname = $"Identification {Entropy}",
                    Status = new Status { Id = 1 },
                }
            );

        return new() {
            Identification = identification,
            Status = new Status {
                Id = 1,
            },
        };
    }


    [Fact(DisplayName = "[View]: Correct generation of [Employee] View.")]
    public async Task View() {
        Store(10, EmployeeFactory);

        SetViewOut<Employee> setViewOut = await Service.View(
                new SetViewOptions<Employee> {
                    Page = 1,
                    Range = 10,
                    Retroactive = false,
                }
            );

        Assert.Equal(10, setViewOut.Length);
    }
}
