using CSM_Database_Core.Depots.Models;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc;

using TWS_Customer.Features.Security;

using TWS_Foundation.Authentication;

using TWS_Customer.Managers.Auth;

namespace TWS_Foundation.Controllers.Security;

[ApiController, Feature("Permits"), Route("[Controller]/[Action]")]
public class PermitsController
    : ControllerBase {

    readonly IPermitsService Service;
    public PermitsController(IPermitsService Service) {
        this.Service = Service;
    }

    [HttpPost(), Action("View")]
    public async Task<IActionResult> View(ViewInput<Permit> options) {
        return Ok(
                await Service.View(
                        new QueryInput<Permit, ViewInput<Permit>> {
                            Parameters = options
                        }
                    )
            );
    }

    [HttpPost(), Action("Create")]
    public async Task<IActionResult> Create(Permit[] permits) {
        return Ok(await Service.Create(permits));
    }

    [HttpPost(), Action("Update")]
    public async Task<IActionResult> Update(UpdateInput<Permit> permit) {
        UpdateOutput<Permit> Output = await Service.Update(permit);
        return Ok(Output);
    }

    [HttpPost(), Action("Delete")]
    public async Task<IActionResult> Delete(int Id) {
        return Ok(await Service.Delete(Id));
    }
}
