using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc;

using TWS_Customer.Features.Security;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Security;

[ApiController, Feature("Accounts"), Route("[Controller]/[Action]")]
public class AccountsController
    : ControllerBase {

    readonly IAccountsService Service;
    
    public AccountsController(IAccountsService Service) {
        this.Service = Service;
    }

    [HttpPost(), Action("View")]
    public async Task<IActionResult> View(ViewInput<Account> options) {
        return Ok(
                await Service.View(
                        new QueryInput<Account, ViewInput<Account>> {
                            Parameters = options
                        }
                    )
            );
    }
}
