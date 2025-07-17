using Microsoft.AspNetCore.Mvc.Testing;

using TWS_Business.Entities.Vehicules.Trailers;

namespace TWS_Foundation.Quality.Q_Controllers.Business;

/// <summary>
///     Represents a tests suit for { Trailers } feature server controller.
///     
///     <para> 
///         A <see cref="Trailer_Common"/> entity represents a physical business asset that are used to carry goods along locations.
///     </para>
/// </summary>
public class Q_TrailersController
    : BQ_Controller<Trailer_Common> {

    /// <summary>
    ///     Creates a new instance.
    /// </summary>
    /// <param name="hostFactory">
    ///     Fixture proxy application factory dependency.
    /// </param>
    public Q_TrailersController(WebApplicationFactory<Program> hostFactory) 
        : base("Trailers", hostFactory) {
    }

    protected override Trailer_Common EntityFactory(string entropyValue) {
        throw new NotImplementedException();
    }
}
