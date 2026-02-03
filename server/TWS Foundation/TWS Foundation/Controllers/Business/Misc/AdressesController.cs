using CSM_Database_Core.Depots.Models;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Entities;

using TWS_Customer.Features.Business;

using TWS_Foundation.Authentication;

using TWS_Customer.Managers.Auth;

namespace TWS_Foundation.Controllers.Business.Misc;

[ApiController, Feature("Addresses"), Route("[Controller]/[Action]")]
public class AddressesController
    : ControllerBase {

    readonly IAddressesService Service;

    public AddressesController(IAddressesService Service) {
        this.Service = Service;
    }

    [HttpPost(), Action("View")]
    public async Task<IActionResult> View(ViewInput<Address> options) {
        return Ok(
                await Service.View(
                        new QueryInput<Address, ViewInput<Address>> {
                            Parameters = options
                        }
                    )
            );
    }
}
