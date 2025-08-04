using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Entities.Vehicules;

using TWS_Customer.Features.Business.Vehicules;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business.Vehicules;

[ApiController, Feature("LoadTypes"), Route("[Controller]/[Action]")]
public class LoadTypesController
    : ControllerBase {

    readonly ILoadTypesService service;

    public LoadTypesController(ILoadTypesService Service) {
        service = Service;
    }

    [HttpPost, Action("View")]
    public async Task<IActionResult> View(ViewInput<LoadType> options) => Ok(
        await service.View(
                new QueryInput<LoadType, ViewInput<LoadType>> {
                    Parameters = options
                }
            )
        );

    [HttpPost, Action("Read")]
    public async Task<IActionResult> View(string reference) => Ok(
           await service.Read(reference)
       );
}
