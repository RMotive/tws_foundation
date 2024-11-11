using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

using TWS_Business.Sets;

namespace TWS_Business.Quality.Sets;
public class Q_Approach : BQ_Set<Approach> {
    protected override Q_MigrationSet_EvaluateRecord<Approach>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<Approach>[] Container) {

        Q_MigrationSet_EvaluateRecord<Approach> success = new("Success") {
            Mock = new() {
                Id = 1,
                Status = 1

            },
            Expectations = [],
        };
        Q_MigrationSet_EvaluateRecord<Approach> failAllCases = new("All properties fail") {
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