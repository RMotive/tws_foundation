using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;
using CSM_Foundation.Database.Models.Options;
using Microsoft.AspNetCore.Mvc;
using TWS_Business.Sets;
using TWS_Customer.Services.Interfaces;
using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Business;

[ApiController, Route("[Controller]")]
public class LocationsController : ControllerBase{
    private readonly ILocationsService Service;

    public LocationsController(ILocationsService Service) {
        this.Service = Service;
    }

    [HttpPost("[Action]"), Auth("Locations", "Read")]
    public async Task<IActionResult> View(SetViewOptions<Location> Options) {
        return Ok(await Service.View(Options));
    }

    [HttpPost("[Action]"), Auth("Locations", "Create")]
    public async Task<IActionResult> Create(Location[] Locations) {
        return Ok(await Service.Create(Locations));
    }

    [HttpPost("[Action]"), Auth("Locations", "Update")]
    public async Task<IActionResult> Update(Location Location) {
        return Ok(await Service.Update(Location));
    }
}
