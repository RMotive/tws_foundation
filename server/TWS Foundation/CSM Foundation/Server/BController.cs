using Microsoft.AspNetCore.Mvc;

namespace CSM_Foundation.Server;

/// <summary>
///     [Abstract] class for [CSM] base controllers, holding and keeping the concept of controller per service.
/// </summary>
public abstract class BController<TService>
    : ControllerBase {

    /// <summary>
    ///     Feature main customer service 
    /// </summary>
    protected readonly TService _service;

    /// <summary>
    ///     Creates a new <see cref="BController{TService}"/> instance
    /// </summary>
    /// <param name="service">
    ///     [Required] dependency main feature service.
    /// </param>
    public BController(TService service) {
        this._service = service;
    }
}
