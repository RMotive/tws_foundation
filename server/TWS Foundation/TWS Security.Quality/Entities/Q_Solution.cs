using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Security.Entities.Solutions;


namespace TWS_Security.Quality.Entities;
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
            Mock = new() { },
            Expectations = [
                (nameof(Solution.Id), [(new PointerValidator(), 3)]),
                (nameof(Solution.Name), [(new LengthValidator(), 1)]),
                (nameof(Solution.Sign), [(new LengthValidator(), 1)]),
            ],
        };

        Container = [.. Container, success, failure];
        return Container;
    }
}
