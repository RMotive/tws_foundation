using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Server;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Entities;

using TWS_Customer.Features.Business;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;

/// <summary>
///     [Controller] that represents [YardLogs] feature based operations.
/// </summary>
[ApiController, Feature("YardLogs"), Route("[Controller]/[Action]")]
public class YardLogsController
    : BController<IYardLogsService> {

    /// <summary>
    ///     Creates a new <see cref="YardLogsController"/> instance.
    /// </summary>
    /// <param name="service">
    ///     [Required Dependency] that holds main feature business operations.
    /// </param>
    public YardLogsController(IYardLogsService service) : base(service) { }

    /// <summary>
    ///     
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost(), Auth("View")]
    public async Task<IActionResult> View(ViewInput<YardLog> input) {
        ViewOutput<YardLog> output = await _service.View(
                new OperationInput<YardLog, ViewInput<YardLog>> {
                    Parameters = input
                }
            );

        return Ok(output);
    }
}
