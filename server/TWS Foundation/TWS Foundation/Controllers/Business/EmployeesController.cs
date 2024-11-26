using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;

[ApiController, Route("[Controller]/[Action]")]
public class EmployeesController : ControllerBase {
    private readonly IEmployeesService Service;
    public EmployeesController(IEmployeesService service) {
        Service = service;
    }

    [HttpPost(), Auth("", "")]
    public async Task<IActionResult> View(SetViewOptions<Employee> Options) {
        return Ok(await Service.View(Options));
    }
}
