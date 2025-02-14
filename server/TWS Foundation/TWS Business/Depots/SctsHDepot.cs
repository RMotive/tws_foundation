using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Interfaces;

using TWS_Business.Entities;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="SctsHDepot"/> dataDatabases entity mirror.
/// </summary>
public class SctsHDepot
: BDepot<BusinessDatabase, SctH> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="SctsHDepot"/>.
    /// </summary>
    public SctsHDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public SctsHDepot() : base(new(), null) {
    }
}
