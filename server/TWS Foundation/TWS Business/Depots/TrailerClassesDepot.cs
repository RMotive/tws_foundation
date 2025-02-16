using CSM_Foundation.Database.Entity;

using TWS_Business.Entities;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="TrailerClass"/> dataDatabases entity mirror.
/// </summary>
public class TrailerClassesDepot : BDepot<BusinessDatabase, TrailerClass> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="TrailerClass"/>.
    /// </summary>
    public TrailerClassesDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public TrailerClassesDepot() : base(new(), null) {
    }
}
