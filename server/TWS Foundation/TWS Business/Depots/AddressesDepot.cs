﻿using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BMigrationDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Address"/> dataDatabases entity mirror.
/// </summary>
public class AddressesDepot : BDepot<TWSBusinessDatabase, Address> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Address"/>.
    /// </summary>
    public AddressesDepot(TWSBusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public AddressesDepot() : base(new(), null) {
    }
}
