using CSM_Database_Core.Depots.Models;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Entities.Vehicules;

using TWS_Customer.Features.Business.Vehicules;

using TWS_Customer.Managers.Auth;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business.Vehicules;

[ApiController, Feature("VehiculeModels"), Route("[Controller]/[Action]")]
public class VehiculeModelsController
    : ControllerBase {

    readonly IVehiculeModelsService Service;

    public VehiculeModelsController(IVehiculeModelsService Service) {
        this.Service = Service;
    }

    [HttpPost(), Action("View")]
    public async Task<IActionResult> View(ViewInput<VehiculeModel> options) {
        return Ok(
                await Service.View(
                        new QueryInput<VehiculeModel, ViewInput<VehiculeModel>> {
                            Parameters = options
                        }
                    )
            );
    }
}
