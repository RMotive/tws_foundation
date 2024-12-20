﻿using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

using TWS_Business.Sets;

namespace TWS_Business.Quality.Sets;
public class Q_Insurance : BQ_Set<Insurance> {
    protected override Q_MigrationSet_EvaluateRecord<Insurance>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<Insurance>[] Container) {

        Q_MigrationSet_EvaluateRecord<Insurance> success = new("Success") {
            Mock = new() {
                Id = 1,
                Policy = "",
                Country = "",
                Expiration = DateOnly.FromDateTime(new DateTime()),

            },
            Expectations = [],
        };
        Q_MigrationSet_EvaluateRecord<Insurance> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
                Policy = "",
                Country = "",
                Status = 0

            },
            Expectations = [
                (nameof(Insurance.Id), [(new PointerValidator(), 3)]),
                (nameof(Insurance.Policy), [(new LengthValidator(), 2)]),
                (nameof(Insurance.Country), [(new LengthValidator(), 2)]),
                (nameof(Insurance.Status), [(new PointerValidator(true), 3)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}