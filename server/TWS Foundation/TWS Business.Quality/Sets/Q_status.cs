﻿using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

using TWS_Business.Sets;

namespace TWS_Business.Quality.Sets;
public class Q_Status : BQ_Set<Status> {
    protected override Q_MigrationSet_EvaluateRecord<Status>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<Status>[] Container) {

        Q_MigrationSet_EvaluateRecord<Status> success = new() {
            Mock = new() {
                Id = 1,
                Name = "",

            },
            Expectations = [],
        };
        Q_MigrationSet_EvaluateRecord<Status> failAllCases = new() {
            Mock = new() {
                Id = 0,
                Name = "Situation validation test, max lengh 25 characters",
                Description = ""
            },
            Expectations = [
                (nameof(Status.Id), [(new PointerValidator(), 3)]),
                (nameof(Status.Name), [(new LengthValidator(), 3)]),
            ],
        };



        Container = [.. Container, success, failAllCases];


        return Container;
    }
}