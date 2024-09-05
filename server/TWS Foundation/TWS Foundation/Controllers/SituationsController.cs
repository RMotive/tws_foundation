﻿using CSM_Foundation.Database.Models.Options;

using Microsoft.AspNetCore.Mvc;

using TWS_Foundation.Controllers.Authentication;

using TWS_Business.Sets;

using TWS_Customer.Services.Interfaces;

namespace TWS_Foundation.Controllers;

[ApiController, Route("[Controller]")]
public class SituationsController : ControllerBase {
    private readonly ISituationsService Service;

    public SituationsController(ISituationsService service) {
        this.Service = service;
    }

    [HttpPost("[Action]"), Auth(["ABC1", "ABC2"])]
    public async Task<IActionResult> View(SetViewOptions<Situation> Options) {
        return Ok(await Service.View(Options));
    }

    [HttpPost("[Action]"), Auth(["ABC1", "ABC2"])]
    public async Task<IActionResult> Create(Situation situation) {
        return Ok(await Service.Create(situation));
    }
}
