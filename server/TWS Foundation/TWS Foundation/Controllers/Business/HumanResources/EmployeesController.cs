using CSM_Database_Core.Depots.Models;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Entities.Employees;

using TWS_Customer.Features.Business;

using TWS_Foundation.Authentication;

using TWS_Customer.Managers.Auth;

namespace TWS_Foundation.Controllers.Business.HumanResources;

[ApiController, Feature("Employees"), Route("[Controller]/[Action]")]
public class EmployeesController
    : ControllerBase {

    readonly IEmployeesService _service;

    public EmployeesController(IEmployeesService Service) {
        this._service = Service;
    }

    [HttpPost, Action("View")]
    public async Task<IActionResult> View(ViewInput<Employee> options) {
        return Ok(
                await _service.View(
                        new QueryInput<Employee, ViewInput<Employee>> {
                            Parameters = options
                        }
                    )
            );
    }

    [HttpGet, Action("Get")]
    public async Task<IActionResult> Get() => Ok(await _service.Get());
}
