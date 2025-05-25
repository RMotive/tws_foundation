using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Entities.Vehicules.Trailers;

using TWS_Customer.Features.Business;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;

[ApiController, Feature("TrailerClasses"), Route("[Controller]/[Action]")]
public class TrailerClassesController
    : ControllerBase {

    readonly ITrailerClassesService Service;

    public TrailerClassesController(ITrailerClassesService Service) {
        this.Service = Service;
    }

    [HttpPost(), Auth("View")]
    public async Task<IActionResult> View(ViewInput<Trailer_Class> options) {
        return Ok(
                await Service.View(
                        new OperationInput<Trailer_Class, ViewInput<Trailer_Class>> {
                            Parameters = options
                        }
                    )
            );
    }
}
