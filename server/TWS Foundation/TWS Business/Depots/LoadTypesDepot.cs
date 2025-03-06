using CSM_Foundation.Database.Entity;

using TWS_Business.Entities;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="LoadType"/> dataDatabases entity mirror.
/// </summary>
public class LoadTypesDepot : BDepot<Database, LoadType> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="AxisLoadType/>.
    /// </summary>
    public LoadTypesDepot(Database Databases, IDisposer? Disposer = null)
        : base(Databases, Disposer) {
    }
    public LoadTypesDepot() : base(new(), null) {
    }
}
