using CSM_Foundation.Database.Entity;

namespace TWS_Business.Entities.Trailers;
/// <summary>
///     Implements a <see cref="BDatabasesDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Trailer_Type"/> dataDatabases entity mirror.
/// </summary>
public class TrailersTypesDepot : BDepot<BusinessDatabase, Trailer_Type> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Trailer_Type"/>.
    /// </summary>
    public TrailersTypesDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public TrailersTypesDepot() : base(new(), null) {
    }
}
