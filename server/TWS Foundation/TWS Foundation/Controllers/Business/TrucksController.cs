using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;
/// <summary>
///     Represents the controller to perform trucks operations.
/// </summary>
[ApiController, Route("[Controller]/[Action]")]
public class TrucksController : ControllerBase {
    private readonly ITrucksService Service;
    public TrucksController(ITrucksService service) {
        Service = service;
    }

    [HttpPost(), Auth("", "")]
    public async Task<IActionResult> View(SetViewOptions<Truck> Options) {
        return Ok(await Service.View(Options));
    }

    [HttpPost(), Auth("", "")]
    public async Task<IActionResult> Create(Truck[] trucks) {
        return Ok(await Service.Create(trucks));
    }

    [HttpPost(), Auth("", "")]
    public async Task<IActionResult> Update(Truck Truck) {
        return Ok(await Service.Update(Truck));
    }
}
