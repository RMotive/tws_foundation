﻿using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

using TWS_Business.Sets;

namespace TWS_Business.Quality.Sets;
public class Q_Identification : BQ_Set<Identification> {
    protected override Q_MigrationSet_EvaluateRecord<Identification>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<Identification>[] Container) {

        Q_MigrationSet_EvaluateRecord<Identification> success = new("Success") {
            Mock = new() {
                Id = 1,
                Status = 1,
                Name = "",
                FatherLastname = "",
                MotherLastName = ""
            },
            Expectations = [],
        };
        Q_MigrationSet_EvaluateRecord<Identification> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
                Status = 0,
            },
            Expectations = [
                (nameof(Identification.Id), [(new PointerValidator(), 3)]),
                (nameof(Identification.Name), [(new RequiredValidator(), 1), (new LengthValidator(), 1)]),
                (nameof(Identification.FatherLastname), [(new RequiredValidator(), 1), (new LengthValidator(), 1)]),
                (nameof(Identification.MotherLastName), [(new RequiredValidator(), 1), (new LengthValidator(), 1)]),
                (nameof(Identification.Status), [(new PointerValidator(true), 3)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}