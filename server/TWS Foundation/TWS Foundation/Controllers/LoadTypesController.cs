using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Foundation.Controllers.Authentication;
using TWS_Customer.Services.Interfaces;
using TWS_Business.Sets;

namespace TWS_Foundation.Controllers;

[ApiController, Route("[Controller]/[Action]")]
public class LoadTypesController : ControllerBase {
    private readonly ILoadTypesService Service;
    public LoadTypesController(ILoadTypesService service) {
        Service = service;
    }

    [HttpPost(), Auth([])]
    public async Task<IActionResult> View(SetViewOptions<LoadType> Options) {
        return Ok(await Service.View(Options));
    }
}
