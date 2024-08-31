﻿using CSM_Foundation.Core.Utils;
using CSM_Foundation.Databases.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="ApproachesHDepot"/>.
/// </summary>
public class Q_ApproachesHDepot
    : BQ_MigrationDepot<ApproachesH, ApproachesHDepot, TWSBusinessDatabase> {
    public Q_ApproachesHDepot()
        : base(nameof(ApproachesH.Entity)) {
    }

    protected override ApproachesH MockFactory() {

        return new() {
            Entity = 1,
            Status = 1,
            Sequence = 1,
            //Timemark = DateTime.Now,

            Email = RandomUtils.String(10)
        };
    }
}
