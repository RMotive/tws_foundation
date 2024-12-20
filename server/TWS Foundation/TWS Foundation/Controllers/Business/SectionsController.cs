﻿using CSM_Foundation.Database.Models.Options;

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

    [HttpPost(), Auth("", "")]
    public async Task<IActionResult> View(SetViewOptions<Section> Options) {
        return Ok(await Service.View(Options));
    }
}
