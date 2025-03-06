using CSM_Foundation.Database.Entity;

namespace TWS_Business.Entities.Trailers;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Trailer_Common"/> dataDatabases entity mirror.
/// </summary>
public class TrailersCommonsDepot : BDepot<BusinessDatabase, Trailer_Common> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Trailer_Common"/>.
    /// </summary>
    public TrailersCommonsDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public TrailersCommonsDepot() : base(new(), null) {
    }
}
