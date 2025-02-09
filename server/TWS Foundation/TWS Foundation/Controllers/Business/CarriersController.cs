using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;

[ApiController, Feature("Carriers"), Route("[Controller]/[Action]")]
public class CarriersController : ControllerBase {
    private readonly ICarriersService Service;

    public CarriersController(ICarriersService Service) {
        this.Service = Service;
    }

    [HttpPost(), Auth("View")]
    public async Task<IActionResult> View(SetViewOptions<Carrier> Options) {
        return Ok(await Service.View(Options));
    }

    [HttpPost(), Auth("Create")]
    public async Task<IActionResult> Create(Carrier carrier) {
        return Ok(await Service.Create(carrier));
    }
}
