using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Depot;

using TWS_Business.Entities.Drivers;

namespace TWS_Business.Depots;

/// <summary>
///     [Depot] handler for <see cref="Driver_Common"/>
/// </summary>
public class Drivers_CommonsDepot
    : BCommonDepot<Database, Driver, DriverExternal, Driver_Common> {

    /// <summary>
    ///     Creates a new <see cref="Drivers_CommonsDepot"/> instance with custom handlers.
    /// </summary>
    /// <param name="Database">
    ///     Database context handler.
    /// </param>
    /// <param name="Disposer">
    ///     Disposition manager handler.
    /// </param>
    public Drivers_CommonsDepot(Database Database, IDisposer? Disposer)
        : base(Database, Disposer) {
    }

    /// <summary>
    ///     Creates a new <see cref="Drivers_CommonsDepot"/> with default handlers.
    /// </summary>
    /// <remarks>
    ///     This constructor will generate a <see cref="BDepot{TDatabase, TEntity}"/> using the source database default constructor and no <see cref="IDisposer"/>.
    /// </remarks>
    public Drivers_CommonsDepot()
        : base(new Database(), null) {
    }
}
