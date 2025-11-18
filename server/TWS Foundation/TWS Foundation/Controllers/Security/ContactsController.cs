using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
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

    [HttpPost(), Action("View")]
    public async Task<IActionResult> View(ViewInput<Contact> options) {
        return Ok(
                await Service.View(
                        new QueryInput<Contact, ViewInput<Contact>> {
                            Parameters = options
                        }
                    )
            );
    }

    [HttpPost(), Action("Create")]
    public async Task<IActionResult> Create(Contact[] contacts) {
        return Ok(await Service.Create(contacts));
    }

    [HttpPost(), Action("Update")]
    public async Task<IActionResult> Update(UpdateInput<Contact> contact) {
        UpdateOutput<Contact> Output = await Service.Update(contact);
        return Ok(Output);
    }
}
