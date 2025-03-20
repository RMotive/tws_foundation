using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Entity.Models.Input.Update;
using CSM_Foundation.Database.Entity.Models.Output;

using CSM_Security.Entities;

using Microsoft.AspNetCore.Mvc;

using TWS_Customer.Features.Security;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Security;

[ApiController, Feature("Solution"), Route("[Controller]/[Action]")]
public class SolutionsController
    : ControllerBase {

    readonly ISolutionsService Service;
    public SolutionsController(ISolutionsService Service) {
        this.Service = Service;
    }

    [HttpPost(), Auth("View")]
    public async Task<IActionResult> View(SetViewOptions<Solution> Options) {
        return Ok(await Service.View(Options));
    }

    [HttpPost(), Auth("Create")]
    public async Task<IActionResult> Create(Solution[] Solutions) {
        return Ok(await Service.Create(Solutions));
    }

    [HttpPost(), Auth("Update")]
    public async Task<IActionResult> Update(UpdateInput<Solution> Solution) {
        EntityUpdateOutput<Solution> Output = await Service.Update(Solution);
        return Ok(Output);
    }

    [HttpPost(), Auth("Delete")]
    public async Task<IActionResult> Delete(int Id) {
        return Ok(await Service.Delete(Id));
    }
}
