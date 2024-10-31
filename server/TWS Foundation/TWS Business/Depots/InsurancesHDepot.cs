using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="InsurancesHDepot"/> dataDatabases entity mirror.
/// </summary>
public class InsurancesHDepot
: BDepot<TWSBusinessDatabase, InsuranceH> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="InsurancesHDepot"/>.
    /// </summary>
    public InsurancesHDepot(TWSBusinessDatabase Databases, IDisposer? Disposer = null)
        : base(Databases, Disposer) {
    }

    public InsurancesHDepot() : base(new(), null) {
    }
}
