using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;

[ApiController, Route("[Controller]")]
public class ManufacturersController : ControllerBase {
    private readonly IManufacturersService Service;

    public ManufacturersController(IManufacturersService Service) {
        this.Service = Service;
    }

    [HttpPost("[Action]"), Auth("Manufacturers", "Read")]
    public async Task<IActionResult> View(SetViewOptions<Manufacturer> Options) {
        return Ok(await Service.View(Options));
    }

}
