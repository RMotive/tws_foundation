using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Entities.Employees;

using TWS_Customer.Features.Business;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;

[ApiController, Feature("Employees"), Route("[Controller]/[Action]")]
public class EmployeesController
    : ControllerBase {

    readonly IEmployeesService Service;

    public EmployeesController(IEmployeesService Service) {
        this.Service = Service;
    }

    [HttpPost(), Auth("View")]
    public async Task<IActionResult> View(ViewInput<Employee> options) {
        return Ok(
                await Service.View(
                        new OperationInput<Employee, ViewInput<Employee>> {
                            Parameters = options
                        }
                    )
            );
    }
}
