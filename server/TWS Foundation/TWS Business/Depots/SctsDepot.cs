using CSM_Foundation.Database.Entity;

using TWS_Business.Entities;


namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="SCT"/> dataDatabases entity mirror.
/// </summary>
public class SctsDepot
: BDepot<BusinessDatabase, SCT> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="SCT"/>.
    /// </summary>
    public SctsDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public SctsDepot()
        : base(new(), null) {

    }

}
