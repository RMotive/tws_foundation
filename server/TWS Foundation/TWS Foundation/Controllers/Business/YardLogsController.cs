using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;

[ApiController, Feature("Yardlogs"), Route("[Controller]/[Action]")]
public class YardLogsController : ControllerBase {
    private readonly IYardLogsService Service;
    public YardLogsController(IYardLogsService service) {
        Service = service;
    }

    [HttpPost(), Auth("View Inventory")]
    public async Task<IActionResult> ViewInventory(SetViewOptions<YardLog> Options) {
        return Ok(await Service.ViewInventory(Options));
    }

    [HttpPost(), Auth("View")]
    public async Task<IActionResult> View(SetViewOptions<YardLog> Options) {
        return Ok(await Service.View(Options));
    }

    [HttpPost(), Auth("Create")]
    public async Task<IActionResult> Create(YardLog[] yardLogs) {
        return Ok(await Service.Create(yardLogs));
    }

    [HttpPost(), Auth("Update")]
    public async Task<IActionResult> Update(YardLog yardLogs) {
        return Ok(await Service.Update(yardLogs));
    }

    [HttpPost(), Auth("Delete")]
    public async Task<IActionResult> Delete(YardLog yardLog) {
        return Ok(await Service.Delete(yardLog));
    }

    [HttpPost(), Auth("Export View")]
    public async Task<IActionResult> ExportView(SetViewOptions<YardLog> Options) {
        return Ok(await Service.ExportView(Options));
    }

    [HttpPost(), Auth("Export Inventory")]
    public async Task<IActionResult> ExportInventory(SetViewOptions<YardLog> Options) {
        return Ok(await Service.ExportInventory(Options));
    }
}
