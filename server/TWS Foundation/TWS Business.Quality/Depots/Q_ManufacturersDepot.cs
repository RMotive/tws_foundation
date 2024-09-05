﻿using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="ManufacturersDepot"/>.
/// </summary>
public class Q_ManufacturersDepot
    : BQ_MigrationDepot<Manufacturer, ManufacturersDepot, TWSBusinessDatabase> {
    public Q_ManufacturersDepot()
        : base(nameof(Manufacturer.Model)) {
    }

    protected override Manufacturer MockFactory() {
        DateOnly date = new(2024, 12, 12);

        return new() {
            Model = RandomUtils.String(30),
            Brand = RandomUtils.String(15),
            Year = date,
        };
    }
}