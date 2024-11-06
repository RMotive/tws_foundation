using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;

[ApiController, Route("[Controller]")]
public class VehiculesModelsController : ControllerBase {
    private readonly IVehiculesModelsService Service;

    public VehiculesModelsController(IVehiculesModelsService Service) {
        this.Service = Service;
    }

    [HttpPost("[Action]"), Auth("", "")]
    public async Task<IActionResult> View(SetViewOptions<VehiculeModel> Options) {
        return Ok(await Service.View(Options));
    }

    [HttpPost("[Action]"), Auth("", "")]
    public async Task<IActionResult> Create(VehiculeModel vehiculeModel) {
        return Ok(await Service.Create(vehiculeModel));
    }
}
