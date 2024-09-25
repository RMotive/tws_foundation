﻿using CSM_Foundation.Database.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Insurance"/> dataDatabases entity mirror.
/// </summary>
public class InsurancesDepot : BDepot<TWSBusinessDatabase, Insurance> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Insurance"/>.
    /// </summary>
    public InsurancesDepot() : base(new(), null) {
    }
}
