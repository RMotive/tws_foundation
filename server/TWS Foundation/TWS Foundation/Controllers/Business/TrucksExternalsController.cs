using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;

[ApiController, Route("[Controller]/[Action]")]
public class TrucksExternalsController : ControllerBase {
    private readonly ITrucksExternalsService Service;
    public TrucksExternalsController(ITrucksExternalsService service) {
        Service = service;
    }

    [HttpPost(), Auth([])]
    public async Task<IActionResult> View(SetViewOptions<TruckExternal> Options) {
        return Ok(await Service.View(Options));
    }

    [HttpPost(), Auth([])]
    public async Task<IActionResult> Create(TruckExternal[] trucks)
        => Ok(await Service.Create(trucks));

    [HttpPost(), Auth([])]
    public async Task<IActionResult> Update(TruckExternal Truck) {
        return Ok(await Service.Update(Truck));
    }
}
