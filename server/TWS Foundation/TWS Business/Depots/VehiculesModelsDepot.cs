﻿using CSM_Foundation.Database.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDatabasesDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="VehiculeModel"/> dataDatabases entity mirror.
/// </summary>
public class VehiculesModelsDepot : BDepot<TWSBusinessDatabase, VehiculeModel> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="VehiculeModel"/>.
    /// </summary>
    public VehiculesModelsDepot() : base(new(), null) {
    }
}