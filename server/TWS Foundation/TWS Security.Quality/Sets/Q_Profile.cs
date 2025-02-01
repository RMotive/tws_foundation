using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

using TWS_Security.Sets;

namespace TWS_Security.Quality.Sets;
public class Q_Profile
    : BQ_Set<Profile> {
    protected override Q_MigrationSet_EvaluateRecord<Profile>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<Profile>[] Container) {
        Q_MigrationSet_EvaluateRecord<Profile> success = new("Success") {
            Mock = new() {
                Id = 1,
            },
            Expectations = [],
        };
        Q_MigrationSet_EvaluateRecord<Profile> failure = new("All properties fail") {
            Mock = new() { },
            Expectations = [
                (nameof(Profile.Id), [(new PointerValidator(), 3)]),
                (nameof(Profile.Name), [(new RequiredValidator(), 1), (new LengthValidator(), 1)]),
            ],
        };

        return [.. Container, success, failure];
    }
}
