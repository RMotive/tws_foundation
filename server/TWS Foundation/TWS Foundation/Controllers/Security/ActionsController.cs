using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc;

using TWS_Customer.Features.Security;

using TWS_Foundation.Authentication;

using Action = CSM_Security.Entities.Action;

namespace TWS_Foundation.Controllers.Security;

[ApiController, Feature("Actions"), Route("[Controller]/[Action]")]
public class ActionsController
    : ControllerBase {

    readonly IActionsService Service;
    public ActionsController(IActionsService Service) {
        this.Service = Service;
    }

    [HttpPost(), Action("View")]
    public async Task<IActionResult> View(ViewInput<Action> options) {
        return Ok(
                await Service.View(
                        new QueryInput<Action, ViewInput<Action>> {
                            Parameters = options
                        }
                    )
            );
    }
}
