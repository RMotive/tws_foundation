using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Server;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Entities;

using TWS_Customer.Features.Business;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business.Gatekeeping;

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
    [HttpPost(), Action("View")]
    public async Task<IActionResult> View(ViewInput<YardLog> input) {
        ViewOutput<YardLog> output = await _service.View(
                new QueryInput<YardLog, ViewInput<YardLog>> {
                    Parameters = input
                }
            );

        return Ok(output);
    }
}
