using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Entities.Vehicules.Trailers;

using TWS_Customer.Features.Business;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business.Vehicules;


[ApiController, Route("[Controller]/[Action]")]
[Feature("Trailers")]
public class TrailersController
    : ControllerBase {

    /// <summary>
    ///     Feature service dependency.
    /// </summary>
    readonly ITrailersService _service;

    /// <summary>
    ///     Creates a new instance.
    /// </summary>
    public TrailersController(ITrailersService service) {
        _service = service;
    }


    [HttpPost, Action("View")]
    public async Task<IActionResult> View(ViewInput<Trailer_Common> input)
    => Ok(
            await _service.View(
                    new QueryInput<Trailer_Common, ViewInput<Trailer_Common>> {
                        Parameters = input
                    }
                )
        );
}
