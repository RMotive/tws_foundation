using CSM_Foundation.Database.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BMigrationDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Address"/> dataDatabases entity mirror.
/// </summary>
public class AddressesDepot : BDatabaseDepot<TWSBusinessDatabase, Address> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Address"/>.
    /// </summary>
    public AddressesDepot() : base(new(), null) {
    }
}
