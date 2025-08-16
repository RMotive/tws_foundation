using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Entities.Vehicules.Trucks;

using TWS_Customer.Features.Business;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business.Vehicules;

[ApiController, Feature("Trucks"), Route("[Controller]/[Action]")]
public class TrucksController
    : ControllerBase {

    readonly ITrucksService Service;
    public TrucksController(ITrucksService Service) {
        this.Service = Service;
    }

    [HttpPost(), Action("View")]
    public async Task<IActionResult> View(ViewInput<Truck_Common> options) {
        return Ok(
                await Service.View(
                        new QueryInput<Truck_Common, ViewInput<Truck_Common>> {
                            Parameters = options
                        }
                    )
            );
    }

    [HttpPost(), Action("Create")]
    public async Task<IActionResult> Create(Truck_Common[] trucks) {
        return Ok(await Service.Create(trucks));
    }

    [HttpPost(), Action("Update")]
    public async Task<IActionResult> Update(UpdateInput<Truck_Common> truck) {
        UpdateOutput<Truck_Common> Output = await Service.Update(truck);
        return Ok(Output);
    }

    [HttpPost(), Action("Delete")]
    public async Task<IActionResult> Delete(Truck_Common entity) {
        return Ok(await Service.Delete(entity));
    }
}
