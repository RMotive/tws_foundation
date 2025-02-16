using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;

namespace TWS_Business.Quality.Entities;
public class Q_DriverCommon : BQ_Entity<DriverCommon> {
    protected override Q_EntityEvaluation<DriverCommon>[] EvaluateFactory(Q_EntityEvaluation<DriverCommon>[] Container) {

        Q_EntityEvaluation<DriverCommon> success = new("Success") {
            Mock = new() {
                Id = 1,
                Situation = 0,
                License = ""

            },
            Expectations = [],
        };
        Q_EntityEvaluation<DriverCommon> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
                License = "",
                Status = 0
            },
            Expectations = [
                (nameof(DriverCommon.Id), [(new PointerValidator(), 3)]),
                (nameof(DriverCommon.License), [(new RequiredValidator(), 1), (new LengthValidator(),2)]),
                (nameof(DriverCommon.Status), [(new PointerValidator(true), 3) ])
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}