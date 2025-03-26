using CSM_Foundation.Database.Entity.Models;
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

    [HttpPost(), Auth("View")]
    public async Task<IActionResult> View(SetViewInput<Account> options) {
        return Ok(
                await Service.View(
                        new OperationInput<Account, SetViewInput<Account>> {
                            Parameters = options
                        }
                    )
            );
    }
}
