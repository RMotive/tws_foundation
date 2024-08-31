﻿using CSM_Foundation.Databases.Quality.Bases;
using CSM_Foundation.Databases.Quality.Records;
using CSM_Foundation.Databases.Validators;

using TWS_Business.Sets;

namespace TWS_Business.Quality.Sets;
public class Q_TrailerCommon : BQ_MigrationSet<TrailerCommon> {
    protected override Q_MigrationSet_EvaluateRecord<TrailerCommon>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<TrailerCommon>[] Container) {

        Q_MigrationSet_EvaluateRecord<TrailerCommon> success = new() {
            Mock = new() {
                Id = 1,
                Class = 1,
                Situation = 1,

            },
            Expectations = [],
        };
        Q_MigrationSet_EvaluateRecord<TrailerCommon> failAllCases = new() {
            Mock = new() {
                Id = 0,
                Status = 0,
                Economic = "",
            },
            Expectations = [
                (nameof(TrailerCommon.Id), [(new PointerValidator(), 3)]),
                (nameof(TrailerCommon.Economic), [(new LengthValidator(),2)]),
                (nameof(DriverCommon.Status), [(new PointerValidator(true), 3) ])
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}