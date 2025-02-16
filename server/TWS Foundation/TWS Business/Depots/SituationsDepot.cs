using CSM_Foundation.Database.Entity;

using TWS_Business.Entities;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Situation"/> dataDatabases entity mirror.
/// </summary>
public class SituationsDepot
    : BDepot<BusinessDatabase, Situation> {

    /// <summary>
    ///     Generates a new depot handler for <see cref="Situation"/>.
    /// </summary>
    public SituationsDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
        : base(Databases, Disposer) {
    }
    public SituationsDepot() : base(new(), null) {

    }
}
