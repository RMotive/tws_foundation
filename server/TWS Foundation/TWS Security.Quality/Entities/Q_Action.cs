using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using Action = TWS_Security.Entities.Action;

namespace TWS_Security.Quality.Entities;
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

        Q_EntityEvaluation<Action> nameMinValue = new("Name min value unreached") {
            Mock = new() {
                Id = 0,
                Name = "",
            },
            Expectations = [
                (nameof(Action.Id), [(new PointerValidator(), 3)]),
                (nameof(Action.Name), [(new LengthValidator(1, 25), 2)])
            ],
        };

        Q_EntityEvaluation<Action> nameMaxValue = new("Name max value overrided") {
            Mock = new() {
                Id = 0,
                Name = "SWFDBWZZUEVWQIXSXZZAAXNTXI",
            },
            Expectations = [
                (nameof(Action.Id), [(new PointerValidator(), 3)]),
                (nameof(Action.Name), [(new LengthValidator(1, 25), 3)])
            ],
        };

        return [
             ..Container,
             noErrors,
             nameMinValue,
             nameMaxValue,
        ];
    }
}
