using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities.Approaches;

namespace TWS_Business.Quality.Entities;
public class Q_Approach : BQ_Entity<Approach> {
    protected override Q_EntityEvaluation<Approach>[] EvaluateFactory(Q_EntityEvaluation<Approach>[] Container) {

        Q_EntityEvaluation<Approach> success = new("Success") {
            Mock = new() {
                Id = 1,
            },
            Expectations = [],
        };
        Q_EntityEvaluation<Approach> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
            },
            Expectations = [
                (nameof(Approach.Id), [(new PointerValidator(), 3)]),
                (nameof(Approach.EMail), [(new RequiredValidator(), 1), (new LengthValidator(), 1)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}