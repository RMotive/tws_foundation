using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;

[ApiController, Route("[Controller]/[Action]")]
public class SectionsController : ControllerBase {
    private readonly ISectionsService Service;
    public SectionsController(ISectionsService service) {
        Service = service;
    }

    [HttpPost(), Auth("Sections", "Read")]
    public async Task<IActionResult> View(SetViewOptions<Section> Options) {
        return Ok(await Service.View(Options));
    }

    [HttpPost(), Auth("Sections", "Create")]
    public async Task<IActionResult> Create(Section[] sections) {
        return Ok(await Service.Create(sections));
    }

    [HttpPost(), Auth("Sections", "Update")]
    public async Task<IActionResult> Update(Section section) {
        return Ok(await Service.Update(section));
    }

    [HttpPost(), Auth("Sections", "Delete")]
    public async Task<IActionResult> Delete(Section section) {
        return Ok(await Service.Delete(section));
    }
}
