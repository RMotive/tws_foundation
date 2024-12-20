﻿using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabaseSet{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="TruckExternal"/> dataDatabases entity mirror.
/// </summary>
public class TrucksExternalsDepot : BDepot<TWSBusinessDatabase, TruckExternal> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="TruckExternal"/>.
    /// </summary>
    public TrucksExternalsDepot(TWSBusinessDatabase Databases, IDisposer? Disposer = null)
       : base(Databases, Disposer) {
    }
    public TrucksExternalsDepot() : base(new(), null) {
    }
}
