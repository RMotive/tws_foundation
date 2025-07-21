using CSM_Foundation.Product;

using Microsoft.AspNetCore.Mvc;

namespace CSM_Foundation.Server;

/// <summary>
///     <see langword="abstract"/> class for <see cref="BController{TService}"/>.
///     
///     <para>
///         Defines base behavior for {CSM} controller implementations, that holds resolvable endpoints direction at the host server to trade data along remote clents.
///     </para>
/// </summary>
/// <typeparam name="TService">
///     Type of the <see cref="IService"/> implementation this <see cref="BController{TService}"/> implementation is based on.
/// </typeparam>
public abstract class BController<TService>
    : ControllerBase 
    where TService : IService {

    /// <summary>
    ///     Feature main customer service 
    /// </summary>
    protected readonly TService _service;

    /// <summary>
    ///     Creates a new <see cref="BController{TService}"/> instance.
    /// </summary>
    /// <param name="service">
    ///     Feature main customer service.
    /// </param>
    public BController(TService service) {
        _service = service;
    }
}
