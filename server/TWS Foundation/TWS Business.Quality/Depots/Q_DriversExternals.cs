﻿using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="DriversExternalsDepot"/>.
/// </summary>
public class Q_DriversExternals
    : BQ_Depot<DriverExternal, DriversExternalsDepot, TWSBusinessDatabase> {
    public Q_DriversExternals()
        : base(nameof(DriverExternal.Id)) {
    }

    protected override DriverExternal MockFactory(string RandomSeed) {

        return new() {
            Status = 1,
            Common = 0,
            Identification = 1,
            DriverCommonNavigation = new() {
                Timestamp = DateTime.Now,
                Status = 1,
                License = RandomUtils.String(12)
            }
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(DriverExternal Mock) 
    => null;
}