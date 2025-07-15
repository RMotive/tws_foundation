using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Entities.Drivers;

using TWS_Customer.Features.Business;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business.HumanResources;


[ApiController, Feature("Drivers"), Route("[Controller]/[Action]")]
public class DriversController
    : ControllerBase {

    readonly IDriversCommonService _service;

    public DriversController(IDriversCommonService service) {
        _service = service;
    }

    [HttpPost, Action("View")]
    public async Task<IActionResult> View(ViewInput<Driver_Common> options) {
        return Ok(
                await _service.View(
                        new QueryInput<Driver_Common, ViewInput<Driver_Common>> {
                            Parameters = options
                        }
                    )
            );
    }
}
