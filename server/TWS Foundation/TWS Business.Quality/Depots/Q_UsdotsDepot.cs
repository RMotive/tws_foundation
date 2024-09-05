﻿using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="UsdotsDepot"/>.
/// </summary>
public class Q_UsdotsDepot
    : BQ_MigrationDepot<Usdot, UsdotsDepot, TWSBusinessDatabase> {
    public Q_UsdotsDepot()
        : base(nameof(Usdot.Mc)) {
    }

    protected override Usdot MockFactory() {
        return new() {
            Status = 1,
            Mc = "MCtestT",
            Scac = "SCAT"
        };
    }
}