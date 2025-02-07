using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;

[ApiController, Feature("Trailers"), Route("[Controller]/[Action]")]
public class TrailersController : ControllerBase {
    private readonly ITrailersService Service;
    public TrailersController(ITrailersService service) {
        Service = service;
    }

    [HttpPost(), Auth("View")]
    public async Task<IActionResult> View(SetViewOptions<Trailer> Options) {
        return Ok(await Service.View(Options));
    }
}
