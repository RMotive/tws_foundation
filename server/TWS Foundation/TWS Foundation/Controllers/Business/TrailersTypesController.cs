using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;

[ApiController, Route("[Controller]")]
public class TrailersTypesController : ControllerBase {
    private readonly ITrailersTypesService Service;

    public TrailersTypesController(ITrailersTypesService Service) {
        this.Service = Service;
    }

    [HttpPost("[Action]"), Auth([])]
    public async Task<IActionResult> View(SetViewOptions<TrailerType> Options) {
        return Ok(await Service.View(Options));
    }

}
