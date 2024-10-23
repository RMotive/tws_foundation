using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

using TWS_Business.Sets;

namespace TWS_Business.Quality.Sets;
public class Q_TrailerCommon : BQ_Set<TrailerCommon> {
    protected override Q_MigrationSet_EvaluateRecord<TrailerCommon>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<TrailerCommon>[] Container) {

        Q_MigrationSet_EvaluateRecord<TrailerCommon> success = new() {
            Mock = new() {
                Id = 1,
                Type = 1,
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
                (nameof(TrailerCommon.Economic), [(new RequiredValidator(), 1), (new LengthValidator(),2)]),
                (nameof(DriverCommon.Status), [(new PointerValidator(true), 3) ])
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}