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

    [HttpPost(), Auth("Read")]
    public async Task<IActionResult> View(SetViewOptions<Trailer> Options) {
        return Ok(await Service.View(Options));
    }
    [HttpPost(), Auth("Create")]
    public async Task<IActionResult> Create(Trailer[] Trailers) {
        return Ok(await Service.Create(Trailers));
    }

    [HttpPost(), Auth("Update")]
    public async Task<IActionResult> Update(Trailer Trailer) {
        return Ok(await Service.Update(Trailer));
    }

    [HttpPost(), Auth("Delete")]
    public async Task<IActionResult> Delete(Trailer Trailer) {
        return Ok(await Service.Delete(Trailer));
    }
}
