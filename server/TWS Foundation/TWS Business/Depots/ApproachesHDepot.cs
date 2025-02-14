using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Interfaces;

using TWS_Business.Entities;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabasesDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="ApproachesH"/> dataDatabases entity mirror.
/// </summary>
public class ApproachesHDepot : BDepot<BusinessDatabase, ApproachesH> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="ApproachesH"/>.
    /// </summary>
    public ApproachesHDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
      : base(Databases, Disposer) {
    }
    public ApproachesHDepot() : base(new(), null) {
    }
}
