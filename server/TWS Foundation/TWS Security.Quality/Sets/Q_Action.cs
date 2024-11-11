using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

namespace TWS_Security.Quality.Sets;
public class Q_Action
    : BQ_Set<TWS_Security.Sets.Action> {
    protected override Q_MigrationSet_EvaluateRecord<TWS_Security.Sets.Action>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<TWS_Security.Sets.Action>[] Container) {
        Q_MigrationSet_EvaluateRecord<TWS_Security.Sets.Action> noErrors = new("Success") {
            Mock = new() {
                Id = 1,
                Name = "A",
            },
            Expectations = [],
        };

        Q_MigrationSet_EvaluateRecord<TWS_Security.Sets.Action> nameMinValue = new("Name min value unreached") {
            Mock = new() {
                Id = 0,
                Name = "",
            },
            Expectations = [
                (nameof(TWS_Security.Sets.Action.Id), [(new PointerValidator(), 3)]),
                (nameof(TWS_Security.Sets.Action.Name), [(new LengthValidator(1, 25), 2)])
            ],
        };

        Q_MigrationSet_EvaluateRecord<TWS_Security.Sets.Action> nameMaxValue = new("Name max value overrided") {
            Mock = new() {
                Id = 0,
                Name = "SWFDBWZZUEVWQIXSXZZAAXNTXI",
            },
            Expectations = [
                (nameof(TWS_Security.Sets.Action.Id), [(new PointerValidator(), 3)]),
                (nameof(TWS_Security.Sets.Action.Name), [(new LengthValidator(1, 25), 3)])
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
