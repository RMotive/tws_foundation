using CSM_Foundation.Database.Entity;

using TWS_Business.Entities.Vehicules;


namespace TWS_Business.Depots.Vehicules;

/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="SCT"/> dataDatabases entity mirror.
/// </summary>
public class SCTDepot
: BDepot<Database, SCT> {
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
