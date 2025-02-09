using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;

[ApiController, Feature("Manufacturers"), Route("[Controller]/[Action]")]
public class ManufacturersController : ControllerBase {
    private readonly IManufacturersService Service;

    public ManufacturersController(IManufacturersService Service) {
        this.Service = Service;
    }

    [HttpPost("[Action]"), Auth("View")]
    public async Task<IActionResult> View(SetViewOptions<Manufacturer> Options) {
        return Ok(await Service.View(Options));
    }

    [HttpPost("[Action]"), Auth("Create")]
    public async Task<IActionResult> Create(Manufacturer manufacturer) {
        return Ok(await Service.Create(manufacturer));
    }
}
