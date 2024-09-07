﻿using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="ApproachesDepot"/>.
/// </summary>
public class Q_ApproachesDepot
    : BQ_Depot<Approach, ApproachesDepot, TWSBusinessDatabase> {
    public Q_ApproachesDepot()
        : base(nameof(Approach.Email)) {
    }

    protected override Approach MockFactory(string RandomSeed) {
        return new() {
            Status = 1,
            Email = "mail@test.com"
        };
    }
}