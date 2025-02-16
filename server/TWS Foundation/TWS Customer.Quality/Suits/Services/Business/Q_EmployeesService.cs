using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Business;
using TWS_Business.Entities.Employees;

using TWS_Customer.Services.Business.Employees;

namespace TWS_Customer.Quality.Suits.Services.Business;


public class Q_EmployeesService
    : BQ_Service<Employee, EmployeesService, BusinessDatabase> {
    public Q_EmployeesService()
        : base(new(new EmployeesDepot())) {

    }

    protected override Employee ComposeSample(string Entropy) {
        return new Employee {
            Identification = 1,
            Status = 1,
        };
    }


    [Fact(DisplayName = "[View]: Correct generation of [Employee] View.")]
    public async Task View() {

        SetViewOut<Employee> setViewOut = await Service.View(
                new SetViewOptions<Employee> {
                    Page = 1,
                    Range = 10,
                    Retroactive = false,
                }
            );
    }
}
