﻿using CSM_Foundation.Databases.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabasesDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Carrier"/> dataDatabases entity mirror.
/// </summary>
public class CarriersDepot : BDatabaseDepot<TWSBusinessDatabases, Carrier> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Carrier"/>.
    /// </summary>
    public CarriersDepot() : base(new(), null) {
    }
}