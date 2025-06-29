using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Entities.Vehicules.Trailers;

using TWS_Customer.Features.Business.Vehicules;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;

[ApiController, Feature("TrailerTypes"), Route("[Controller]/[Action]")]
public class TrailerTypesController
    : ControllerBase {

    readonly ITrailerTypesService Service;

    public TrailerTypesController(ITrailerTypesService Service) {
        this.Service = Service;
    }

    [HttpPost(), Action("View")]
    public async Task<IActionResult> View(ViewInput<Trailer_Type> options) {
        return Ok(
                await Service.View(
                        new QueryInput<Trailer_Type, ViewInput<Trailer_Type>> {
                            Parameters = options
                        }
                    )
            );
    }
}
