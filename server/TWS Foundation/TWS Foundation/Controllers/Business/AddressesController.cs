using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;

[ApiController, Route("[Controller]/[Action]")]
public class AddressesController : ControllerBase {
    private readonly IAddressesService Service;
    public AddressesController(IAddressesService service) {
        Service = service;
    }

    [HttpPost(), Auth("Addresses", "Read")]
    public async Task<IActionResult> View(SetViewOptions<Address> Options) {
        return Ok(await Service.View(Options));
    }
}
