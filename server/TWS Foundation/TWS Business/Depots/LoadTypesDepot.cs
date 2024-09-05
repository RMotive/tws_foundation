﻿using CSM_Foundation.Database.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabaseDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="LoadType"/> dataDatabases entity mirror.
/// </summary>
public class LoadTypesDepot : BDatabaseDepot<TWSBusinessDatabase, LoadType> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="AxisLoadType/>.
    /// </summary>
    public LoadTypesDepot() : base(new(), null) {
    }
}
