using CSM_Foundation.Database.Entity;

using TWS_Business.Entities;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BMigrationDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Address"/> dataDatabases entity mirror.
/// </summary>
public class AddressesDepot 
    : BDepot<Database, Address> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Address"/>.
    /// </summary>
    public AddressesDepot(Database Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public AddressesDepot() : base(new(), null) {
    }
}
