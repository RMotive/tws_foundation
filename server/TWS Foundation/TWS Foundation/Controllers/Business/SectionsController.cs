using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Entities;

using TWS_Customer.Features.Business;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;

[ApiController, Feature("Sections"), Route("[Controller]/[Action]")]
public class SectionsController
    : ControllerBase {

    readonly ISectionsService Service;

    public SectionsController(ISectionsService Service) {
        this.Service = Service;
    }

    [HttpPost(), Auth("View")]
    public async Task<IActionResult> View(ViewInput<Section> options) {
        return Ok(
                await Service.View(
                        new OperationInput<Section, ViewInput<Section>> {
                            Parameters = options
                        }
                    )
            );
    }

    [HttpPost(), Auth("Create")]
    public async Task<IActionResult> Create(Section[] Sections) {
        return Ok(await Service.Create(Sections));
    }

    [HttpPost(), Auth("Update")]
    public async Task<IActionResult> Update(UpdateInput<Section> Section) {
        UpdateOutput<Section> Output = await Service.Update(Section);
        return Ok(Output);
    }
}
