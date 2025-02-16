using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;

namespace TWS_Business.Quality.Entities;
public class Q_Approach : BQ_Entity<Approach> {
    protected override Q_EntityEvaluation<Approach>[] EvaluateFactory(Q_EntityEvaluation<Approach>[] Container) {

        Q_EntityEvaluation<Approach> success = new("Success") {
            Mock = new() {
                Id = 1,
                Status = 1

            },
            Expectations = [],
        };
        Q_EntityEvaluation<Approach> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
                Status = 0
            },
            Expectations = [
                (nameof(Approach.Id), [(new PointerValidator(), 3)]),
                (nameof(Approach.Email), [(new RequiredValidator(), 1), (new LengthValidator(), 1)]),
                (nameof(Approach.Status), [(new PointerValidator(true), 3)]),

            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}