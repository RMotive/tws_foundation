using CSM_Foundation.Databases.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabaseDepot{TMigrationSource, TMigrationSet}"/>
///     representing a depot to handle <see cref="Situation"/> datasource entity mirror.
/// </summary>
public class SituationsDepot
    : BDatabaseDepot<TWSBusinessSource, Situation> {

    /// <summary>
    ///     Generates a new depot handler for <see cref="Situation"/>.
    /// </summary>
    public SituationsDepot() : base(new(), null) {

    }
}
