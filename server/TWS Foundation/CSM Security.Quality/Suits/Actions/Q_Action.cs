using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using Action = CSM_Security.Entities.Action;

namespace CSM_Security.Quality.Entities.Actions;
public class Q_Action
    : BQ_Entity<Action> {
    protected override Q_EntityEvaluation<Action>[] EvaluateFactory(Q_EntityEvaluation<Action>[] Container) {
        Q_EntityEvaluation<Action> noErrors = new("Success") {
            Mock = new() {
                Id = 1,
                Name = "A",
            },
            Expectations = [],
        };

        return [
             ..Container,
             noErrors,
        ];
    }
}
