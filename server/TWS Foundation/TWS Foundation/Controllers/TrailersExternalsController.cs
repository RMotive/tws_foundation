using CSM_Foundation.Databases.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Foundation.Controllers.Authentication;
using TWS_Customer.Services.Interfaces;

namespace TWS_Foundation.Controllers;

[ApiController, Route("[Controller]/[Action]")]
public class TrailersExternalsController : ControllerBase {
    private readonly ITrailersExternalsService Service;
    public TrailersExternalsController(ITrailersExternalsService service) {
        Service = service;
    }

    [HttpPost(), Auth([])]
    public async Task<IActionResult> View(SetViewOptions Options) {
        return Ok(await Service.View(Options));
    }
}
