using Microsoft.AspNetCore.Mvc;

using TWS_Foundation.Controllers.Authentication;

using TWS_Customer.Services.Interfaces;

using TWS_Security.Sets;

namespace TWS_Foundation.Controllers;


[ApiController, Route("[Controller]")]
public class ContactsController
    : ControllerBase {
    private readonly IContactsService Service;

    public ContactsController(IContactsService service) {
        this.Service = service;
    }

    [HttpPost("[Action]"), Auth(["ABC1", "ABC2"])]

    public async Task<IActionResult> Create(Contact[] contacts) {
        return Ok(await Service.Create(contacts));
    }
}
