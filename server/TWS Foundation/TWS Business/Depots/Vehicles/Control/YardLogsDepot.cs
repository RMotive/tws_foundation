using CSM_Foundation.Database.Entity;

using TWS_Business.Entities;

namespace TWS_Business.Depots.Vehicles.Control;

/// <summary>
///     [Interface] for <see cref="YardLog"/> based 
/// </summary>
public interface IYardLogsDepot
    : IDepot<YardLog> {
}

/// <summary>
///     [Depot] implementation for <see cref="YardLog"/> based entity handler.
/// </summary>
public class YardLogsDepot
    : BDepot<Database, YardLog>, IYardLogsDepot {

    /// <summary>
    ///     Creates a new <see cref="YardLogsDepot"/> instance.
    /// </summary>
    /// <param name="Database">
    ///     Database context handler to be used.
    /// </param>
    /// <param name="Disposer">
    ///     Data disposition handler to be used.
    /// </param>
    public YardLogsDepot(Database Database, IDisposer? Disposer) : base(Database, Disposer) { }
}
