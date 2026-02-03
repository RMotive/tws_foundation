using CSM_Database_Core.Depots.Abstractions.Bases;
using CSM_Database_Core.Depots.Abstractions.Interfaces;
using CSM_Database_Core.Entities.Abstractions.Interfaces;

using CSM_Foundation_Core.Abstractions.Interfaces;

using TWS_Business.Entities;

namespace TWS_Business.Depots;


/// <summary>
///     [Interface] for <see cref="Address"/> based depot implementations.
/// </summary>
public interface IAddressesDepot
    : IDepot<Address> {

}
/// <summary>
///     Implements a <see cref="BMigrationDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Address"/> dataDatabases entity mirror.
/// </summary>
public class AddressesDepot
    : DepotBase<Database, Address>, IAddressesDepot {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Address"/>.
    /// </summary>
    public AddressesDepot(Database Databases, IDisposer<IEntity>? Disposer = null)
       : base(Databases, Disposer) {
    }
    public AddressesDepot() : base(new(), null) {
    }
}
