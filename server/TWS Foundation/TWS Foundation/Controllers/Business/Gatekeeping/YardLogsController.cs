using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Server;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Entities;
using TWS_Business.Entities.Vehicules.Trucks;

using TWS_Customer.Features.Business;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business.Gatekeeping;

/// <summary>
///     [Controller] that represents [YardLogs] feature based operations.
/// </summary>
[ApiController, Feature("YardLogs"), Route("[Controller]/[Action]")]
public class YardLogsController
    : ControllerBase {

    readonly IYardLogsService Service;
    public YardLogsController(IYardLogsService Service) {
        this.Service = Service;
    }

    [HttpPost(), Action("View")]
    public async Task<IActionResult> View(ViewInput<YardLog> options) {
        return Ok(
                await Service.View(
                        new QueryInput<YardLog, ViewInput<YardLog>> {
                            Parameters = options
                        }
                    )
            );
    }

    [HttpPost(), Action("Create")]
    public async Task<IActionResult> Create(YardLog[] yardlogs) {
        return Ok(await Service.Create(yardlogs));
    }

    [HttpPost(), Action("Update")]
    public async Task<IActionResult> Update(UpdateInput<YardLog> yardlog) {
        UpdateOutput<YardLog> Output = await Service.Update(yardlog);
        return Ok(Output);
    }

    [HttpPost(), Action("Delete")]
    public async Task<IActionResult> Delete(YardLog entity) {
        return Ok(await Service.Delete(entity));
    }
}
