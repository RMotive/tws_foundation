﻿using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Customer.Services.Interfaces;

using TWS_Foundation.Controllers.Authentication;

namespace TWS_Foundation.Controllers;

[ApiController, Route("[Controller]/[Action]")]
public class TrucksExternalsController : ControllerBase {
    private readonly ITrucksExternalsService Service;
    public TrucksExternalsController(ITrucksExternalsService service) {
        Service = service;
    }

    [HttpPost(), Auth([])]
    public async Task<IActionResult> View(SetViewOptions Options) {
        return Ok(await Service.View(Options));
    }
}
