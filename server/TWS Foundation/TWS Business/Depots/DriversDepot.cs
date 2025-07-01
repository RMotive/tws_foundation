using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Depot;

using TWS_Business.Depots.Bases;
using TWS_Business.Entities.Drivers;

namespace TWS_Business.Depots;


/// <summary>
///     [Depot] for <see cref="Driver_Common"/> based [Depot] implementations. 
/// </summary>
/// <remarks>
///     This is a shared depot to get <see cref="Driver"/> and <see cref="DriverExternal"/>.
/// </remarks>
public interface IDriversDepot
    : IDepot<Driver_Common> {

}

/// <summary>
///     [Depot] handler for <see cref="Driver_Common"/>
/// </summary>
public class DriversDepot
    : BCommonDepot<Database, Driver, DriverExternal, Driver_Common>, IDriversDepot {

    /// <summary>
    ///     Creates a new <see cref="DriversDepot"/> instance with custom handlers.
    /// </summary>
    /// <param name="Database">
    ///     Database context handler.
    /// </param>
    /// <param name="Disposer">
    ///     Disposition manager handler.
    /// </param>
    public DriversDepot(Database Database, IDisposer? Disposer)
        : base(Database, Disposer) {
    }

    /// <summary>
    ///     Creates a new <see cref="DriversDepot"/> with default handlers.
    /// </summary>
    /// <remarks>
    ///     This constructor will generate a <see cref="BDepot{TDatabase, TEntity}"/> using the source database default constructor and no <see cref="IDisposer"/>.
    /// </remarks>
    public DriversDepot()
        : base(new Database(), null) {
    }
}
