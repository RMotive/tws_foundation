using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;

[ApiController, Route("[Controller]/[Action]")]
public class DriversController : ControllerBase {
    private readonly IDriversService Service;
    public DriversController(IDriversService service) {
        Service = service;
    }

    [HttpPost(), Auth("Drivers", "Read")]
    public async Task<IActionResult> View(SetViewOptions<Driver> Options) {
        return Ok(await Service.View(Options));
    }
    [HttpPost(), Auth("Drivers", "Create")]
    public async Task<IActionResult> Create(Driver[] Drivers) {
        return Ok(await Service.Create(Drivers));
    }

    [HttpPost(), Auth("Drivers", "Update")]
    public async Task<IActionResult> Update(Driver Driver) {
        return Ok(await Service.Update(Driver));
    }
}
