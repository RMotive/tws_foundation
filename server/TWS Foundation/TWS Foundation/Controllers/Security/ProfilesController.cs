using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Customer.Services.Interfaces;

using TWS_Foundation.Authentication;

using TWS_Security.Sets;

namespace TWS_Foundation.Controllers.Security;

[ApiController, Route("[Controller]/[Action]")]
public class ProfilesController
    : ControllerBase {
    private readonly IProfileService Service;
    public ProfilesController(IProfileService Service) {
        this.Service = Service;
    }

    [HttpPost(), Auth("", "")]
    public async Task<IActionResult> View(SetViewOptions<Profile> Options) {
        return Ok(await Service.View(Options));
    }

}
