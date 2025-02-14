using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

using Action = TWS_Security.Entities.Action;

namespace TWS_Security.Quality.Entities;
public class Q_Action
    : BQ_Set<Action> {
    protected override Q_MigrationSet_EvaluateRecord<Action>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<Action>[] Container) {
        Q_MigrationSet_EvaluateRecord<Action> noErrors = new("Success") {
            Mock = new() {
                Id = 1,
                Name = "A",
            },
            Expectations = [],
        };

        Q_MigrationSet_EvaluateRecord<Action> nameMinValue = new("Name min value unreached") {
            Mock = new() {
                Id = 0,
                Name = "",
            },
            Expectations = [
                (nameof(Action.Id), [(new PointerValidator(), 3)]),
                (nameof(Action.Name), [(new LengthValidator(1, 25), 2)])
            ],
        };

        Q_MigrationSet_EvaluateRecord<Action> nameMaxValue = new("Name max value overrided") {
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
