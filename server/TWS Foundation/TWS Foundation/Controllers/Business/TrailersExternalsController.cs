using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;

[ApiController, Route("[Controller]/[Action]")]
public class TrailersExternalsController : ControllerBase {
    private readonly ITrailersExternalsService Service;
    public TrailersExternalsController(ITrailersExternalsService service) {
        Service = service;
    }

    [HttpPost(), Auth("TrailersExternals", "Read")]
    public async Task<IActionResult> View(SetViewOptions<TrailerExternal> Options) {
        return Ok(await Service.View(Options));
    }

    [HttpPost(), Auth("TrailersExternals","Create")]
    public async Task<IActionResult> Create(TrailerExternal[] Trailers) {
        return Ok(await Service.Create(Trailers));
    }

    [HttpPost(), Auth("TrailersExternals","Update")]
    public async Task<IActionResult> Update(TrailerExternal Trailer) {
        return Ok(await Service.Update(Trailer));
    }
}
