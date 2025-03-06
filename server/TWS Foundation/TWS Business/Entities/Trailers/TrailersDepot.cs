using CSM_Foundation.Database.Entity;

namespace TWS_Business.Entities.Trailers;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Trailer"/> dataDatabases entity mirror.
/// </summary>
public class TrailersDepot : BDepot<BusinessDatabase, Trailer> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Trailer"/>.
    /// </summary>
    public TrailersDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public TrailersDepot() : base(new(), null) {
    }
}
