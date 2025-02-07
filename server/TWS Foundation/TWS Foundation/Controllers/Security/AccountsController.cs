using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Customer.Services.Interfaces;

using TWS_Foundation.Authentication;

using TWS_Security.Sets;

namespace TWS_Foundation.Controllers.Security;

[ApiController, Feature("Accounts"), Route("[Controller]/[Action]")]
public class AccountsController
    : ControllerBase {
    private readonly IAccountsService Service;
    public AccountsController(IAccountsService Service) {
        this.Service = Service;
    }

    [HttpPost(), Auth("View")]
    public async Task<IActionResult> View(SetViewOptions<Account> Options) {
        return Ok(await Service.View(Options));
    }
}
