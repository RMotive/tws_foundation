using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Depot;

using TWS_Business.Entities.Vehicules;


namespace TWS_Business.Depots.Vehicles;


/// <summary>
///     [Interface] for <see cref="Plate"/> based [Depot] implementations.
/// </summary>
public interface ISCTsDepot
    : IDepot<SCT> {
}

/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="SCT"/> dataDatabases entity mirror.
/// </summary>
public class SCTDepot
: BDepot<Database, SCT>, ISCTsDepot {
    /// <summary>
    ///     Generates a new depot handler for <see cref="SCT"/>.
    /// </summary>
    public SCTDepot(Database Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public SCTDepot()
        : base(new(), null) {
    }


}
