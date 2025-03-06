using CSM_Foundation.Database.Entity;

namespace TWS_Business.Entities.Trucks;

/// <summary>
/// 
/// </summary>
public class TruckInventory
    : BDepot<Database, TruckEntry> {

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Database"></param>
    /// <param name="Disposer"></param>
    public TruckInventory(Database Database, IDisposer? Disposer = null)
        : base(Database, Disposer) {
    }

    /// <summary>
    ///     
    /// </summary>
    public TruckInventory()
        : base(new(), null) {
    }
}
