using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;

[ApiController, Feature("Vehicule Models"), Route("[Controller]/[Actions]")]
public class VehiculesModelsController : ControllerBase {
    private readonly IVehiculesModelsService Service;

    public VehiculesModelsController(IVehiculesModelsService Service) {
        this.Service = Service;
    }

    [HttpPost("[Action]"), Auth("View")]
    public async Task<IActionResult> View(SetViewOptions<VehiculeModel> Options) {
        return Ok(await Service.View(Options));
    }

    [HttpPost("[Action]"), Auth("Create")]
    public async Task<IActionResult> Create(VehiculeModel vehiculeModel) {
        return Ok(await Service.Create(vehiculeModel));
    }
}
