using CSM_Database_Core.Depots.Models;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Entities.Vehicules.Trailers;

using TWS_Customer.Features.Business.Vehicules;

using TWS_Foundation.Authentication;

using TWS_Customer.Managers.Auth;

namespace TWS_Foundation.Controllers.Business.Vehicules;

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
