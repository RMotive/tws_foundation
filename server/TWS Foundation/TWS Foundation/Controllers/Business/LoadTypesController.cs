using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Entities.Vehicules;

using TWS_Customer.Features.Business;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;

[ApiController, Feature("LoadTypes"), Route("[Controller]/[Action]")]
public class LoadTypesController
    : ControllerBase {

    readonly ILoadTypesService Service;

    public LoadTypesController(ILoadTypesService Service) {
        this.Service = Service;
    }

    [HttpPost(), Auth("View")]
    public async Task<IActionResult> View(ViewInput<LoadType> options) {
        return Ok(
                await Service.View(
                        new OperationInput<LoadType, ViewInput<LoadType>> {
                            Parameters = options
                        }
                    )
            );
    }
}
