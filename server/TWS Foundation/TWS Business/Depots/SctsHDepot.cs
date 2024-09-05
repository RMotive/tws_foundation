﻿using CSM_Foundation.Database.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabaseDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="SctsHDepot"/> dataDatabases entity mirror.
/// </summary>
public class SctsHDepot
: BDatabaseDepot<TWSBusinessDatabase, SctH> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="SctsHDepot"/>.
    /// </summary>
    public SctsHDepot() : base(new(), null) {
    }
}
