using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc;

using TWS_Customer.Features.Security;

using TWS_Foundation.Authentication;

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
    public async Task<IActionResult> Create(Permit[] Solutions) {
        return Ok(await Service.Create(Solutions));
    }

    [HttpPost(), Action("Update")]
    public async Task<IActionResult> Update(UpdateInput<Permit> Solution) {
        UpdateOutput<Permit> Output = await Service.Update(Solution);
        return Ok(Output);
    }

    [HttpPost(), Action("Delete")]
    public async Task<IActionResult> Delete(int Id) {
        return Ok(await Service.Delete(Id));
    }
}
