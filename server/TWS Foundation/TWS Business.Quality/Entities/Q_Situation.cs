using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;

namespace TWS_Business.Quality.Entities;
public class Q_Situation : BQ_Entity<Situation> {
    protected override Q_EntityEvaluation<Situation>[] EvaluateFactory(Q_EntityEvaluation<Situation>[] Container) {

        Q_EntityEvaluation<Situation> success = new("Success") {
            Mock = new() {
                Id = 1,
                Name = "",

            },
            Expectations = [],
        };
        Q_EntityEvaluation<Situation> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
                Name = "Situation validation test, max lengh 25 characters",
            },
            Expectations = [
                (nameof(Situation.Id), [(new PointerValidator(), 3)]),
                (nameof(Situation.Name), [(new LengthValidator(), 3)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}
