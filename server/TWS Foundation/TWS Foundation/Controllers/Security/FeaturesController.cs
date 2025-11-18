using CSM_Foundation.Database.Entity.Depot.IDepot_Update;
using CSM_Foundation.Database.Entity.Depot.IDepot_View;
using CSM_Foundation.Database.Entity.Models.Input;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc;

using TWS_Customer.Features.Security;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Security;

[ApiController, Feature("Features"), Route("[Controller]/[Action]")]
public class FeaturesController
    : ControllerBase {

    readonly IFeaturesService Service;
    public FeaturesController(IFeaturesService Service) {
        this.Service = Service;
    }

    [HttpPost(), Action("View")]
    public async Task<IActionResult> View(ViewInput<Feature> options) {
        return Ok(
                await Service.View(
                        new QueryInput<Feature, ViewInput<Feature>> {
                            Parameters = options
                        }
                    )
            );
    }

    [HttpPost(), Action("Create")]
    public async Task<IActionResult> Create(Feature[] features) {
        return Ok(await Service.Create(features));
    }

    [HttpPost(), Action("Update")]
    public async Task<IActionResult> Update(UpdateInput<Feature> feature) {
        UpdateOutput<Feature> Output = await Service.Update(feature);
        return Ok(Output);
    }

    [HttpPost(), Action("Delete")]
    public async Task<IActionResult> Delete(int Id) {
        return Ok(await Service.Delete(Id));
    }
}
