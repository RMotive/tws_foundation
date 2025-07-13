using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Entities.Vehicules;

using TWS_Customer.Features.Business;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business.Misc;

[ApiController, Feature("Carriers"), Route("[Controller]/[Action]")]
public class CarriersController
    : ControllerBase {

    readonly ICarriersService Service;

    public CarriersController(ICarriersService Service) {
        this.Service = Service;
    }

    [HttpPost(), Action("View")]
    public async Task<IActionResult> View(ViewInput<Carrier> options) {
        return Ok(
                await Service.View(
                        new QueryInput<Carrier, ViewInput<Carrier>> {
                            Parameters = options
                        }
                    )
            );
    }
}
