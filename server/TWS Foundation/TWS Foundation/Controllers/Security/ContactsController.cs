using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Customer.Services.Interfaces;

using TWS_Foundation.Authentication;

using TWS_Security.Sets;

namespace TWS_Foundation.Controllers.Security;


[ApiController]
[Route("[Controller]/[Action]")]
public class ContactsController
    : ControllerBase {
    private readonly IContactsService Service;

    public ContactsController(IContactsService service) {
        Service = service;
    }

    [HttpPost(), Auth("Create")]
    public async Task<IActionResult> Create(Contact[] contacts) {
        return Ok(await Service.Create(contacts));
    }

    [HttpPost(), Auth("View")]
    public async Task<IActionResult> View(SetViewOptions<Contact> Options) {
        return Ok(await Service.View(Options));
    }
}
