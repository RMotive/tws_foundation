using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;

namespace TWS_Business.Quality.Entities;
public class Q_TrailerCommon : BQ_Entity<TrailerCommon> {
    protected override Q_EntityEvaluation<TrailerCommon>[] EvaluateFactory(Q_EntityEvaluation<TrailerCommon>[] Container) {

        Q_EntityEvaluation<TrailerCommon> success = new("Success") {
            Mock = new() {
                Id = 1,
                Type = 1,
                Situation = 1,

            },
            Expectations = [],
        };
        Q_EntityEvaluation<TrailerCommon> failAllCases = new("All properties fail") {
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