using CSM_Foundation.Databases.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabaseDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Section"/> dataDatabases entity mirror.
/// </summary>
public class SectionsDepot : BDatabaseDepot<TWSBusinessDatabase, Section> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Section"/>.
    /// </summary>
    public SectionsDepot() : base(new(), null) {
    }
}
