﻿using CSM_Foundation.Databases.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabasesDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Axis"/> dataDatabases entity mirror.
/// </summary>
public class AxesDepot : BDatabaseDepot<TWSBusinessDatabases, Axis> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Axis"/>.
    /// </summary>
    public AxesDepot() : base(new(), null) {
    }
}