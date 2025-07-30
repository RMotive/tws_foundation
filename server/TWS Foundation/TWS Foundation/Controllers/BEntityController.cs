using CSM_Foundation.Product;

using Microsoft.AspNetCore.Mvc;

namespace TWS_Foundation.Controllers;

[ApiController, Route("[Controller]/[Action]")]
/// <summary>
///     Represents a server controller that handles operations
///     for a business entity.
/// </summary>
/// <typeparam name="TService"></typeparam>
public abstract class BEntityController<TService>
    : ControllerBase
    where TService : IService {


    /// <summary>
    ///     Entity service.
    /// </summary>
    readonly protected TService service;

    /// <summary>
    ///     Creates a new instnace.
    /// </summary>
    /// <param name="service">
    ///     Controller's entity service dependency.
    /// </param>
    public BEntityController(TService service) {
        this.service = service;
    }
}
