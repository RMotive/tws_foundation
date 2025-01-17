using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;

[ApiController, Route("[Controller]/[Action]")]
public class TrucksInventoriesController : ControllerBase {
    private readonly ITrucksInventoriesService Service;

    public TrucksInventoriesController(ITrucksInventoriesService Service) {
        this.Service = Service;
    }

    [HttpPost(), Auth("TrucksInventories", "Read")]
    public async Task<IActionResult> View(SetViewOptions<TruckInventory> Options) {
        return Ok(await Service.View(Options));
    }

}
