using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Entities;

using TWS_Customer.Features.Business;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business.Misc;

[ApiController, Feature("Statuses"), Route("[Controller]/[Action]")]
public class StatusesController
    : ControllerBase {

    readonly IStatusesService service;

    public StatusesController(IStatusesService Service) {
        service = Service;
    }

    [HttpPost(), Action("View")]
    public async Task<IActionResult> View(ViewInput<Status> options) => Ok(
        await service.View(
                new QueryInput<Status, ViewInput<Status>> {
                    Parameters = options
                }
            )
        );

    [HttpGet("{reference}"), Action("read")]
    public async Task<IActionResult> Read(string reference) => Ok(
        
            await service.Read(reference)
        );
}

