using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Entities.Vehicules.Trailers;

using TWS_Customer.Features.Business.Vehicules;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business.Vehicules;

[ApiController, Feature("Trailers"), Route("[Controller]/[Action]")]
public class TrailersController
    : ControllerBase {

    readonly ITrailersService Service;
    public TrailersController(ITrailersService Service) {
        this.Service = Service;
    }

    [HttpPost(), Action("View")]
    public async Task<IActionResult> View(ViewInput<Trailer_Common> options) {
        return Ok(
                await Service.View(
                        new QueryInput<Trailer_Common, ViewInput<Trailer_Common>> {
                            Parameters = options
                        }
                    )
            );
    }

    [HttpPost(), Action("Create")]
    public async Task<IActionResult> Create(Trailer_Common[] trailers) {
        return Ok(await Service.Create(trailers));
    }

    [HttpPost(), Action("Update")]
    public async Task<IActionResult> Update(UpdateInput<Trailer_Common> trailer) {
        UpdateOutput<Trailer_Common> Output = await Service.Update(trailer);
        return Ok(Output);
    }

    [HttpPost(), Action("Delete")]
    public async Task<IActionResult> Delete(Trailer_Common entity) {
        return Ok(await Service.Delete(entity));
    }
}
