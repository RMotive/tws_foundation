using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Entities;

using TWS_Customer.Features.Business;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business.Misc;

[ApiController, Feature("Situations"), Route("[Controller]/[Action]")]
public class SituationsController
    : ControllerBase {

    readonly ISituationsService Service;

    public SituationsController(ISituationsService Service) {
        this.Service = Service;
    }

    [HttpPost(), Action("View")]
    public async Task<IActionResult> View(ViewInput<Situation> options) {
        return Ok(
                await Service.View(
                        new QueryInput<Situation, ViewInput<Situation>> {
                            Parameters = options
                        }
                    )
            );
    }
}
