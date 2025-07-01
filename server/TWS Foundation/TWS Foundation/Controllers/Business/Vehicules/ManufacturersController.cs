using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Entities.Vehicules;

using TWS_Customer.Features.Business.Vehicules;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business.Vehicules;

[ApiController, Feature("Manufacturers"), Route("[Controller]/[Action]")]
public class ManufacturersController
    : ControllerBase {

    readonly IManufacturersService Service;

    public ManufacturersController(IManufacturersService Service) {
        this.Service = Service;
    }

    [HttpPost(), Action("View")]
    public async Task<IActionResult> View(ViewInput<Manufacturer> options) {
        return Ok(
                await Service.View(
                        new QueryInput<Manufacturer, ViewInput<Manufacturer>> {
                            Parameters = options
                        }
                    )
            );
    }
}
