using CSM_Foundation.Database.Entity;

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
///     [Depot] implementation for <see cref="Driver_Common"/> based operations. 
/// </summary>
/// <remarks>
///     This is a shared common depot to get <see cref="Driver"/> and <see cref="DriverExternal"/> based on the <see cref="Driver_Common"/>.
/// </remarks>
public class DriversDepot
    : BDepot<Database, Driver_Common>, IDriversDepot {

    /// <summary>
    ///     Creates a new <see cref="DriversDepot"/> instance.
    /// </summary>
    /// <param name="Database">
    ///     Database context handler to be used.
    /// </param>
    /// <param name="Disposer">
    ///     Data disposition manager handler to be used.
    /// </param>
    public DriversDepot(Database Database, IDisposer? Disposer) : base(Database, Disposer) { }
}
