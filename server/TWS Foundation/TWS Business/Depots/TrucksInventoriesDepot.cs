﻿using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BMigrationDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="TruckInventory"/> dataDatabases entity mirror.
/// </summary>
public class TrucksInventoriesDepot : BDepot<TWSBusinessDatabase, TruckInventory> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="TruckInventory"/>.
    /// </summary>
    public TrucksInventoriesDepot(TWSBusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public TrucksInventoriesDepot() : base(new(), null) {
    }
}
