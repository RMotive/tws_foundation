using CSM_Foundation.Database.Entity;

namespace TWS_Business.Entities.Trucks;

/// <summary>
/// 
/// </summary>
public class TruckInventory
    : BDepot<BusinessDatabase, TruckEntry> {

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Database"></param>
    /// <param name="Disposer"></param>
    public TruckInventory(BusinessDatabase Database, IDisposer? Disposer = null)
        : base(Database, Disposer) {
    }

    /// <summary>
    ///     
    /// </summary>
    public TruckInventory()
        : base(new(), null) {
    }
}
