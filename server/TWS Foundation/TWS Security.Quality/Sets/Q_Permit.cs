using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

using TWS_Security.Sets;

namespace TWS_Security.Quality.Sets;
public class Q_Permit
    : BQ_Set<Permit> {
    protected override Q_MigrationSet_EvaluateRecord<Permit>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<Permit>[] Container) {
        Q_MigrationSet_EvaluateRecord<Permit> success = new("Success") {
            Mock = new() {
                Id = 1,
            },
            Expectations = [],
        };
        Q_MigrationSet_EvaluateRecord<Permit> failure = new("All properties fail") {
            Mock = new() { },
            Expectations = [
                (nameof(Permit.Id), [(new PointerValidator(), 3)]),
                (nameof(Permit.Reference), [(new LengthValidator(), 1)]),
            ],
        };

        return [.. Container, success, failure];
    }
}
