using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Entities;

using TWS_Customer.Features.Business;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business.Misc;

[ApiController, Feature("Locations"), Route("[Controller]/[Action]")]
public class LocationsController
    : ControllerBase {

    readonly ILocationsService Service;
    public LocationsController(ILocationsService Service) {
        this.Service = Service;
    }

    [HttpPost(), Action("View")]
    public async Task<IActionResult> View(ViewInput<Location> options) {
        return Ok(
                await Service.View(
                        new QueryInput<Location, ViewInput<Location>> {
                            Parameters = options
                        }
                    )
            );
    }

    [HttpPost(), Action("Create")]
    public async Task<IActionResult> Create(Location[] Locations) {
        return Ok(await Service.Create(Locations));
    }

    [HttpPost(), Action("Update")]
    public async Task<IActionResult> Update(UpdateInput<Location> Location) {
        UpdateOutput<Location> Output = await Service.Update(Location);
        return Ok(Output);
    }

}
