using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Section"/> dataDatabases entity mirror.
/// </summary>
public class SectionsDepot : BDepot<TWSBusinessDatabase, Section> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Section"/>.
    /// </summary>
    public SectionsDepot(TWSBusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public SectionsDepot() : base(new(), null) {
    }
}
