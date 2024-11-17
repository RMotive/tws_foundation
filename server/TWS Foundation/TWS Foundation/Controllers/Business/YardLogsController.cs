using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;

[ApiController, Route("[Controller]/[Action]")]
public class YardLogsController : ControllerBase {
    private readonly IYardLogsService Service;
    public YardLogsController(IYardLogsService service) {
        Service = service;
    }

    [HttpPost(), Auth("", "")]
    public async Task<IActionResult> ViewInventory(SetViewOptions<YardLog> Options) {
        return Ok(await Service.ViewInventory(Options));
    }

    [HttpPost(), Auth("", "")]
    public async Task<IActionResult> View(SetViewOptions<YardLog> Options) {
        return Ok(await Service.View(Options));
    }

    [HttpPost(), Auth("", "")]
    public async Task<IActionResult> Create(YardLog[] yardLogs) {
        return Ok(await Service.Create(yardLogs));
    }

    [HttpPost(), Auth("", "")]
    public async Task<IActionResult> Update(YardLog yardLogs) {
        return Ok(await Service.Update(yardLogs));
    }

    [HttpPost(), Auth("", "")]
    public async Task<IActionResult> Delete(int Id) {
        return Ok(await Service.Delete(Id));
    }
}
