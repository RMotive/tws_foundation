using Microsoft.AspNetCore.Mvc;

using TWS_Customer.Features.Security;
using TWS_Customer.Managers.Session;
using TWS_Customer.Services.Records;

namespace TWS_Foundation.Controllers.Security;

/// <summary>
///     [Controller] that represents [Security] feature based operations.
/// </summary>
[ApiController, Route("[Controller]/[Action]")]
public class SecurityController
    : ControllerBase {

    /// <summary>
    ///     Main feature (<see cref="ISecurityService"/>) service.
    /// </summary>
    readonly ISecurityService service;

    /// <summary>
    ///     Creates a new <see cref="SecurityController"/> instance.
    /// </summary>
    /// <param name="service">
    ///     [Required dependency] that holds main feature business operations.
    /// </param>
    public SecurityController(ISecurityService service) {
        this.service = service;
    }

    [HttpPost]
    public async Task<IActionResult> Authenticate([FromBody] AuthInput input) => Ok(await service.Authenticate(input));
}
