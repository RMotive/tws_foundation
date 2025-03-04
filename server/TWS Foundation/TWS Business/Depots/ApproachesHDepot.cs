using CSM_Foundation.Database.Entity;

using TWS_Business.Entities.Approaches;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabasesDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Approach_History"/> dataDatabases entity mirror.
/// </summary>
public class ApproachesHDepot : BDepot<BusinessDatabase, Approach_History> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Approach_History"/>.
    /// </summary>
    public ApproachesHDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
      : base(Databases, Disposer) {
    }
    public ApproachesHDepot() : base(new(), null) {
    }
}
