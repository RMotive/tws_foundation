using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using CSM_Security.Entities;

namespace CSM_Security.Quality.Entities.Solutions;
public class Q_Solution
    : BQ_Entity<Solution> {
    protected override Q_EntityEvaluation<Solution>[] EvaluateFactory(Q_EntityEvaluation<Solution>[] Container) {
        const string successName = "TWS Quality";
        const string successSign = "TWSMQ";

        Q_EntityEvaluation<Solution> success = new("Success") {
            Mock = new() {
                Id = 1,
                Name = successName,
                Sign = successSign,
            },
            Expectations = [],
        };
        Q_EntityEvaluation<Solution> failure = new("All properties fail") {
            Mock = new() { 
                    Id = 0,
                },
            Expectations = [
                (nameof(Solution.Id), [(new PointerValidator(), 3)]),
                (nameof(Solution.Sign), [(new LengthValidator(), 2)]),
            ],
        };

        Container = [.. Container, success, failure];
        return Container;
    }
}
