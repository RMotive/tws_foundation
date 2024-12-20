﻿using CSM_Foundation.Database.Bases;
using CSM_Foundation.Database.Interfaces;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Situation"/> dataDatabases entity mirror.
/// </summary>
public class SituationsDepot
    : BDepot<TWSBusinessDatabase, Situation> {

    /// <summary>
    ///     Generates a new depot handler for <see cref="Situation"/>.
    /// </summary>
    public SituationsDepot(TWSBusinessDatabase Databases, IDisposer? Disposer = null)
        : base(Databases, Disposer) {
    }
    public SituationsDepot() : base(new(), null) {

    }
}
