using CSM_Foundation.Database.Entity.Models;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Entities;

using TWS_Customer.Services.Interfaces;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;

[ApiController, Feature("External Trailers"), Route("[Controller]/[Action]")]
public class TrailersExternalsController : ControllerBase {
    private readonly ITrailersExternalsService Service;
    public TrailersExternalsController(ITrailersExternalsService service) {
        Service = service;
    }

    [HttpPost(), Auth("View")]
    public async Task<IActionResult> View(SetViewOptions<TrailerExternal> Options) {
        return Ok(await Service.View(Options));
    }
}
