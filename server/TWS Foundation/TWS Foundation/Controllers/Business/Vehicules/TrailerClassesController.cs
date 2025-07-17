using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Entities.Vehicules.Trailers;

using TWS_Customer.Features.Business.Vehicules;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business.Vehicules;

[ApiController, Feature("TrailerClasses"), Route("[Controller]/[Action]")]
public class TrailerClassesController
    : ControllerBase {

    /// <summary>
    ///     Feature service dependency.
    /// </summary>
    readonly ITrailerClassesService _service;

    public TrailerClassesController(ITrailerClassesService service) {
        _service = service;
    }

    [HttpPost, Action("View")]
    public async Task<IActionResult> View(ViewInput<Trailer_Class> input) {
        return Ok(
                await _service.View(
                        new QueryInput<Trailer_Class, ViewInput<Trailer_Class>> {
                            Parameters = input
                        }
                    )
            );
    }
}
