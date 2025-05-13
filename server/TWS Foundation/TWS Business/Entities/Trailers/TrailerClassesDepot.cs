using CSM_Foundation.Database.Entity;

using TWS_Business.Entities.Vehicules.Trailers;

namespace TWS_Business.Entities.Trailers;

/// <summary>
///     [Interface] for <see cref="Trailer_Class"/> based depot implementations.
/// </summary>
public interface ITrailerClassesDepot
    : IDepot<Trailer_Class> {

}

/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Trailer_Class"/> dataDatabases entity mirror.
/// </summary>
public class TrailerClassesDepot : BDepot<Database, Trailer_Class>, ITrailerClassesDepot {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Trailer_Class"/>.
    /// </summary>
    public TrailerClassesDepot(Database Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public TrailerClassesDepot() : base(new(), null) {
    }
}
