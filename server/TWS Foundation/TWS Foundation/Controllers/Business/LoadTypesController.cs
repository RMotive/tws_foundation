using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;

[ApiController, Feature("LoadTypes"), Route("[Controller]/[Action]")]
public class LoadTypesController : ControllerBase {
    private readonly ILoadTypesService Service;
    public LoadTypesController(ILoadTypesService service) {
        Service = service;
    }

    [HttpPost(), Auth("")]
    public async Task<IActionResult> View(SetViewOptions<LoadType> Options) {
        return Ok(await Service.View(Options));
    }
}
