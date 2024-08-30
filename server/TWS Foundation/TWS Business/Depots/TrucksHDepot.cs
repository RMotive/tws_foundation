﻿using CSM_Foundation.Databases.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabaseDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="TruckH"/> dataDatabases entity mirror.
/// </summary>
public class TrucksHDepot
: BDatabaseDepot<TWSBusinessDatabases, TruckH> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="TruckH"/>.
    /// </summary>
    public TrucksHDepot() : base(new(), null) {
    }
}