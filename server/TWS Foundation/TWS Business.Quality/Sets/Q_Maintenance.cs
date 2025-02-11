﻿using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

using TWS_Business.Sets;

namespace TWS_Business.Quality.Sets;
public class Q_Maintenance : BQ_Set<Maintenance> {
    protected override Q_MigrationSet_EvaluateRecord<Maintenance>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<Maintenance>[] Container) {

        Q_MigrationSet_EvaluateRecord<Maintenance> success = new("Success") {
            Mock = new() {
                Id = 1,
                Anual = DateOnly.FromDateTime(new DateTime()),
                Trimestral = DateOnly.FromDateTime(new DateTime()),
            },
            Expectations = [],
        };
        Q_MigrationSet_EvaluateRecord<Maintenance> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
                Status = 0
            },
            Expectations = [
                (nameof(Maintenance.Id), [(new PointerValidator(), 3)]),
                (nameof(Maintenance.Status), [(new PointerValidator(true), 3)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}