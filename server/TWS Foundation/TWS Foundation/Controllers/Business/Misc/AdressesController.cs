using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Entities;

using TWS_Customer.Features.Business;

using TWS_Foundation.Authentication;

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
