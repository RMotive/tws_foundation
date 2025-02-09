using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;

[ApiController, Feature("Situations"), Route("[Controller]/[Action]")]
public class SituationsController : ControllerBase {
    private readonly ISituationsService Service;

    public SituationsController(ISituationsService service) {
        Service = service;
    }

    [HttpPost(), Auth("View")]
    public async Task<IActionResult> View(SetViewOptions<Situation> Options) {
        return Ok(await Service.View(Options));
    }

    [HttpPost(), Auth("Create")]
    public async Task<IActionResult> Create(Situation situation) {
        return Ok(await Service.Create(situation));
    }
}
