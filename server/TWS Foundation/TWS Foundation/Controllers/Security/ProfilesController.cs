using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc;

using TWS_Customer.Features.Security;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Security;

[ApiController, Feature("Profiles"), Route("[Controller]/[Action]")]
public class ProfilesController
    : ControllerBase {

    readonly IProfilesService Service;
    public ProfilesController(IProfilesService Service) {
        this.Service = Service;
    }

    [HttpPost(), Action("View")]
    public async Task<IActionResult> View(ViewInput<Profile> options) {
        return Ok(
                await Service.View(
                        new QueryInput<Profile, ViewInput<Profile>> {
                            Parameters = options
                        }
                    )
            );
    }

    [HttpPost(), Action("Create")]
    public async Task<IActionResult> Create(Profile[] profiles) {
        return Ok(await Service.Create(profiles));
    }

    [HttpPost(), Action("Update")]
    public async Task<IActionResult> Update(UpdateInput<Profile> permit) {
        UpdateOutput<Profile> Output = await Service.Update(permit);
        return Ok(Output);
    }

    [HttpPost(), Action("Delete")]
    public async Task<IActionResult> Delete(int Id) {
        return Ok(await Service.Delete(Id));
    }
}
