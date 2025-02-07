using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;

[ApiController, Feature("Plates"), Route("[Controller]/[Action]")]
public class PlatesController : ControllerBase {
    private readonly IPlatesService Service;

    public PlatesController(IPlatesService service) {
        Service = service;
    }

    [HttpPost(), Auth("View")]
    public async Task<IActionResult> View(SetViewOptions<Plate> Options) {
        return Ok(await Service.View(Options));
    }

    [HttpPost(), Auth("Create")]
    public async Task<IActionResult> Create(Plate plate) {
        return Ok(await Service.Create(plate));
    }
}
