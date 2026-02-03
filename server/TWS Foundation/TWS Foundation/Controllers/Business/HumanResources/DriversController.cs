using CSM_Database_Core.Depots.Models;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Entities.Drivers;

using TWS_Customer.Features.Business;

using TWS_Foundation.Authentication;

using TWS_Customer.Managers.Auth;

namespace TWS_Foundation.Controllers.Business.HumanResources;

[ApiController, Feature("Driver"), Route("[Controller]/[Action]")]
public class DriversController
    : ControllerBase {

    readonly IDriversService Service;
    public DriversController(IDriversService Service) {
        this.Service = Service;
    }

    [HttpPost(), Action("View")]
    public async Task<IActionResult> View(ViewInput<Driver_Common> options) {
        return Ok(
                await Service.View(
                        new QueryInput<Driver_Common, ViewInput<Driver_Common>> {
                            Parameters = options
                        }
                    )
            );
    }

    [HttpPost(), Action("Create")]
    public async Task<IActionResult> Create(Driver_Common[] Solutions) {
        return Ok(await Service.Create(Solutions));
    }

    [HttpPost(), Action("Update")]
    public async Task<IActionResult> Update(UpdateInput<Driver_Common> Solution) {
        UpdateOutput<Driver_Common> Output = await Service.Update(Solution);
        return Ok(Output);
    }

    [HttpPost(), Action("Delete")]
    public async Task<IActionResult> Delete(Driver_Common entity) {
        return Ok(await Service.Delete(entity));
    }
}
