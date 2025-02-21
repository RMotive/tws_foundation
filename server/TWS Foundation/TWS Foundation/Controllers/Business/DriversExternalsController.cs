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

    [HttpPost(), Auth("DriversExternals", "Read")]
    public async Task<IActionResult> View(SetViewOptions<DriverExternal> Options) {
        return Ok(await Service.View(Options));
    }

    [HttpPost(), Auth("DriversExternals", "Create")]
    public async Task<IActionResult> Create(DriverExternal[] Drivers) {
        return Ok(await Service.Create(Drivers));
    }

    [HttpPost(), Auth("DriversExternals", "Update")]
    public async Task<IActionResult> Update(DriverExternal Driver) {
        return Ok(await Service.Update(Driver));
    }

    [HttpPost(), Auth("DriversExternals", "Delete")]
    public async Task<IActionResult> Delete(DriverExternal Driver) {
        return Ok(await Service.Delete(Driver));
    }
}
