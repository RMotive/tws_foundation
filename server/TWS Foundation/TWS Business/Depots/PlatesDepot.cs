﻿using CSM_Foundation.Databases.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabaseDepot{TMigrationSource, TMigrationSet}"/>
///     representing a depot to handle <see cref="Plate"/> datasource entity mirror.
/// </summary>
public class PlatesDepot
    : BDatabaseDepot<TWSBusinessSource, Plate> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Plate"/>.
    /// </summary>

    public PlatesDepot()
        : base(new(), null) {
    }
}
