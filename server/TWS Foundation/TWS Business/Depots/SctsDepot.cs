using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Interfaces;

using TWS_Business.Entities;


namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Sct"/> dataDatabases entity mirror.
/// </summary>
public class SctsDepot
: BDepot<BusinessDatabase, Sct> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Sct"/>.
    /// </summary>
    public SctsDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public SctsDepot()
        : base(new(), null) {

    }

}
