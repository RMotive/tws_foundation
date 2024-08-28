﻿using CSM_Foundation.Core.Utils;
using CSM_Foundation.Databases.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="CarriersDepot"/>.
/// </summary>
public class Q_CarriersDepot
    : BQ_MigrationDepot<Carrier, CarriersDepot, TWSBusinessDatabases> {
    public Q_CarriersDepot()
        : base(nameof(Carrier.Id)) {
    }

    protected override Carrier MockFactory() {

        return new() {
            Name = "Carrier name",
            Approach = 1,
            Address = 1,
            Status = 1,
        };
    }
}