using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Customer.Services.Interfaces;

using TWS_Foundation.Authentication;

using TWS_Security.Sets;

namespace TWS_Foundation.Controllers.Security;

[ApiController, Route("[Controller]/[Action]")]
public class PermitsController
    : ControllerBase {
    private readonly IPermitsService Service;
    public PermitsController(IPermitsService Service) {
        this.Service = Service;
    }

    [HttpPost(), Auth("", "")]
    public async Task<IActionResult> View(SetViewOptions<Permit> Options) {
        return Ok(await Service.View(Options));
    }

}
