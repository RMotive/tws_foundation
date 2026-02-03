using CSM_Database_Core.Depots.Models;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Entities;

using TWS_Customer.Features.Business;

using TWS_Foundation.Authentication;

using TWS_Customer.Managers.Auth;

namespace TWS_Foundation.Controllers.Business.Gatekeeping;

[ApiController, Feature("Sections"), Route("[Controller]/[Action]")]
public class SectionsController
    : ControllerBase {

    readonly ISectionsService Service;

    public SectionsController(ISectionsService Service) {
        this.Service = Service;
    }

    [HttpPost(), Action("View")]
    public async Task<IActionResult> View(ViewInput<Section> options) {
        return Ok(
                await Service.View(
                        new QueryInput<Section, ViewInput<Section>> {
                            Parameters = options
                        }
                    )
            );
    }

    [HttpPost(), Action("Create")]
    public async Task<IActionResult> Create(Section[] Sections) {
        return Ok(await Service.Create(Sections));
    }

    [HttpPost(), Action("Update")]
    public async Task<IActionResult> Update(UpdateInput<Section> Section) {
        UpdateOutput<Section> Output = await Service.Update(Section);
        return Ok(Output);
    }
}
