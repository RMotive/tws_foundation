using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;

[ApiController, Route("[Controller]/[Action]")]
public class DriversExternalsController : ControllerBase {
    private readonly IDriversExternalsService Service;
    public DriversExternalsController(IDriversExternalsService service) {
        Service = service;
    }

    [HttpPost(), Auth("Drivers", "Read")]
    public async Task<IActionResult> View(SetViewOptions<DriverExternal> Options) {
        return Ok(await Service.View(Options));
    }

    [HttpPost(), Auth("Drivers", "Create")]
    public async Task<IActionResult> Create(DriverExternal[] Drivers) {
        return Ok(await Service.Create(Drivers));
    }

    [HttpPost(), Auth("Drivers", "Update")]
    public async Task<IActionResult> Update(DriverExternal Driver) {
        return Ok(await Service.Update(Driver));
    }
}
