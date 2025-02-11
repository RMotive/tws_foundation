﻿using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabasesDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="DriverExternal"/> dataDatabases entity mirror.
/// </summary>
public class DriversExternalsDepot : BDepot<TWSBusinessDatabase, DriverExternal> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="DriverExternal"/>.
    /// </summary>
    public DriversExternalsDepot(TWSBusinessDatabase Databases, IDisposer? Disposer = null)
        : base(Databases, Disposer) {
    }
    public DriversExternalsDepot() : base(new(), null) {
    }
}
