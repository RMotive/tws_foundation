using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;

[ApiController, Route("[Controller]/[Action]")]
public class TrailersClassesController : ControllerBase {
    private readonly ITrailersClassesService Service;

    public TrailersClassesController(ITrailersClassesService Service) {
        this.Service = Service;
    }

    [HttpPost(), Auth("TrailerClassses","Read")]
    public async Task<IActionResult> View(SetViewOptions<TrailerClass> Options) {
        return Ok(await Service.View(Options));
    }

}
