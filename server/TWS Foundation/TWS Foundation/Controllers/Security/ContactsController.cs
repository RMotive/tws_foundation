using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Entity.Models.Input;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc;

using TWS_Customer.Features.Security;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Security;


[ApiController]
[Route("[Controller]/[Action]")]
public class ContactsController
    : ControllerBase {

    readonly IContactsService Service;

    public ContactsController(IContactsService service) {
        Service = service;
    }

    [HttpPost(), Auth("Create")]
    public async Task<IActionResult> Create(Contact[] contacts) {
        return Ok(await Service.Create(contacts));
    }

    [HttpPost(), Auth("View")]
    public async Task<IActionResult> View(SetViewInput<Contact> options) {
        return Ok(
                await Service.View(
                        new OperationInput<Contact, SetViewInput<Contact>> {
                            Parameters = options
                        }
                    )
            );
    }
}
