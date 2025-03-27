using Microsoft.AspNetCore.Mvc;

using TWS_Customer.Features.Security;
using TWS_Customer.Services.Records;

namespace TWS_Foundation.Controllers.Security;

/// <summary>
///     Represents the controller to perform secutiry operations.
/// </summary>
[ApiController, Route("[Controller]")]
public class SecurityController
    : ControllerBase {

    readonly ISecurityService Service;
    public SecurityController(ISecurityService Service) {
        this.Service = Service;
    }

    [HttpPost("[Action]")]
    public async Task<IActionResult> Authenticate([FromBody] AuthenticationInput Credentials) {
        return Ok(await Service.Authenticate(Credentials));
    }
}
