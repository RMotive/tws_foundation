﻿using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality.Bases;

using TWS_Business.Depots;
using TWS_Business.Sets;

namespace TWS_Business.Quality.Depots;
/// <summary>
///     Qualifies the <see cref="IdentificationsDepot"/>.
/// </summary>
public class Q_IdentificationsDepot
    : BQ_MigrationDepot<Identification, IdentificationsDepot, TWSBusinessDatabase> {
    public Q_IdentificationsDepot()
        : base(nameof(Identification.Id)) {
    }

    protected override Identification MockFactory() {

        return new() {
            Name = "Identifications name",
            Status = 1,
            FatherLastname = "Father last name",
            MotherLastName = "Mother last name"
        };
    }
}