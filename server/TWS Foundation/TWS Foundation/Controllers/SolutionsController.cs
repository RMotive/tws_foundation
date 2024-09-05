using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Foundation.Controllers.Authentication;

using TWS_Customer.Services.Interfaces;

using TWS_Security.Sets;

namespace TWS_Foundation.Controllers;

[ApiController, Route("[Controller]/[Action]")]
public class SolutionsController
    : ControllerBase {
    private readonly ISolutionsService Service;
    public SolutionsController(ISolutionsService Service) {
        this.Service = Service;
    }

    [HttpPost(), Auth([])]
    public async Task<IActionResult> View(SetViewOptions<Solution> Options) {
        return Ok(await Service.View(Options));
    }

    [HttpPost(), Auth([])]
    public async Task<IActionResult> Create(Solution[] Solutions) {
        return Ok(await Service.Create(Solutions));
    }

    [HttpPost(), Auth([])]
    public async Task<IActionResult> Update(Solution Solution) {
        return Ok(await Service.Update(Solution));
    }

    [HttpPost(), Auth([])]
    public async Task<IActionResult> Delete(int Id) {
        return Ok(await Service.Delete(Id));
    }
}
