using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Foundation.Controllers.Authentication;
using TWS_Customer.Services.Interfaces;
using TWS_Business.Sets;

namespace TWS_Foundation.Controllers;

[ApiController, Route("[Controller]/[Action]")]
public class DriversController : ControllerBase {
    private readonly IDriversService Service;
    public DriversController(IDriversService service) {
        Service = service;
    }

    [HttpPost(), Auth([])]
    public async Task<IActionResult> View(SetViewOptions<Driver> Options) {
        return Ok(await Service.View(Options));
    }
}
