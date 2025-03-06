using CSM_Foundation.Database.Entity;

namespace TWS_Business.Entities.Trailers;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Trailer_Class"/> dataDatabases entity mirror.
/// </summary>
public class TrailerClassesDepot : BDepot<BusinessDatabase, Trailer_Class> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Trailer_Class"/>.
    /// </summary>
    public TrailerClassesDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public TrailerClassesDepot() : base(new(), null) {
    }
}
