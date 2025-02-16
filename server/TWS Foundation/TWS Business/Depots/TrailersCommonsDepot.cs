using CSM_Foundation.Database.Entity;

using TWS_Business.Entities;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="TrailerCommon"/> dataDatabases entity mirror.
/// </summary>
public class TrailersCommonsDepot : BDepot<BusinessDatabase, TrailerCommon> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="TrailerCommon"/>.
    /// </summary>
    public TrailersCommonsDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public TrailersCommonsDepot() : base(new(), null) {
    }
}
