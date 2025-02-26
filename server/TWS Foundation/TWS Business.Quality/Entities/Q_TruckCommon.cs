using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;

namespace TWS_Business.Quality.Entities;
public class Q_TruckCommon : BQ_Entity<TruckCommon> {
    protected override Q_EntityEvaluation<TruckCommon>[] EvaluateFactory(Q_EntityEvaluation<TruckCommon>[] Container) {

        Q_EntityEvaluation<TruckCommon> success = new("Success") {
            Mock = new() {
                Id = 1,
                Economic = "",
                Situation = new Situation {
                    Id = 1,
                }

            },
            Expectations = [],
        };
        Q_EntityEvaluation<TruckCommon> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
                Economic = "",
            },
            Expectations = [
                (nameof(TruckCommon.Id), [(new PointerValidator(), 3)]),
                (nameof(TruckCommon.Economic), [(new RequiredValidator(), 1), (new LengthValidator(),2)]),
                (nameof(TruckCommon.Status), [(new PointerValidator(), 3)]),

            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}