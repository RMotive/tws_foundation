﻿using CSM_Foundation.Core.Utils;
using CSM_Foundation.Databases.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="DriversExternalsDepot"/>.
/// </summary>
public class Q_DriversExternals
    : BQ_MigrationDepot<DriverExternal, DriversExternalsDepot, TWSBusinessDatabase> {
    public Q_DriversExternals()
        : base(nameof(DriverExternal.Id)) {
    }

    protected override DriverExternal MockFactory() {

        return new() {
            Status = 1,
            Common = 0,
            Identification = 1,
            DriverCommonNavigation = new() {
                Status = 1,
                License = RandomUtils.String(12)
            }
        };
    }
}