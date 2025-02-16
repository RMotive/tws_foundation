using CSM_Foundation.Database.Entity;

using TWS_Business.Entities;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Section"/> dataDatabases entity mirror.
/// </summary>
public class SectionsDepot : BDepot<BusinessDatabase, Section> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Section"/>.
    /// </summary>
    public SectionsDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public SectionsDepot() : base(new(), null) {
    }
}
