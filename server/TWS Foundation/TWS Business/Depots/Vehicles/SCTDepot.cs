using CSM_Database_Core.Depots.Abstractions.Bases;
using CSM_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Foundation_Core.Abstractions.Interfaces;

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
: DepotBase<Database, SCT>, ISCTsDepot {
    /// <summary>
    ///     Generates a new depot handler for <see cref="SCT"/>.
    /// </summary>
    public SCTDepot(Database Databases, IDisposer<IEntity>? Disposer = null)
       : base(Databases, Disposer) {
    }
    public SCTDepot()
        : base(new(), null) {
    }


}
