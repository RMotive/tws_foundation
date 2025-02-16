using CSM_Foundation.Database.Entity;

using TWS_Business.Entities;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="InsurancesHDepot"/> dataDatabases entity mirror.
/// </summary>
public class InsurancesHDepot
: BDepot<BusinessDatabase, InsuranceH> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="InsurancesHDepot"/>.
    /// </summary>
    public InsurancesHDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
        : base(Databases, Disposer) {
    }

    public InsurancesHDepot() : base(new(), null) {
    }
}
