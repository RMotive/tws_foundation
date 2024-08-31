using CSM_Foundation.Databases.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabaseDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="InsurancesHDepot"/> dataDatabases entity mirror.
/// </summary>
public class InsurancesHDepot
: BDatabaseDepot<TWSBusinessDatabase, InsuranceH> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="InsurancesHDepot"/>.
    /// </summary>
    public InsurancesHDepot() : base(new(), null) {
    }
}
