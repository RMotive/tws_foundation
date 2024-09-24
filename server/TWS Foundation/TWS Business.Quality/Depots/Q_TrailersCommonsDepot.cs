﻿using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="TrailersCommonsDepot"/>.
/// </summary>
public class Q_TrailersCommonsDepot
    : BQ_Depot<TrailerCommon, TrailersCommonsDepot, TWSBusinessDatabase> {
    public Q_TrailersCommonsDepot()
        : base(nameof(TrailerCommon.Id)) {
    }

    protected override TrailerCommon MockFactory(string RandomSeed) {

        return new() {
            Class = 1,
            Status = 1,
            Economic = RandomUtils.String(16),
            Situation = 1,
            Location = 1
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(TrailerCommon Mock) {
        return (nameof(TrailerCommon.Economic), Mock.Economic);
    }
}