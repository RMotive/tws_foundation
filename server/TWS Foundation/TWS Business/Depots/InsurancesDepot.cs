using CSM_Foundation.Databases.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabaseDepot{TMigrationSource, TMigrationSet}"/>
///     representing a depot to handle <see cref="Insurance"/> datasource entity mirror.
/// </summary>
public class InsurancesDepot : BDatabaseDepot<TWSBusinessSource, Insurance> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Insurance"/>.
    /// </summary>
    public InsurancesDepot() : base(new(), null) {
    }
}
