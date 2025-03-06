using CSM_Foundation.Database.Entity;

namespace TWS_Business.Entities.Plates;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Plate"/> dataDatabases entity mirror.
/// </summary>
public class PlatesDepot
    : BDepot<BusinessDatabase, Plate> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Plate"/>.
    /// </summary>
    public PlatesDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public PlatesDepot()
        : base(new(), null) {
    }
}
