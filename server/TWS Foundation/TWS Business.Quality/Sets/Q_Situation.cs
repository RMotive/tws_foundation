using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

using TWS_Business.Sets;

namespace TWS_Business.Quality.Sets;
public class Q_Situation : BQ_MigrationSet<Situation> {
    protected override Q_MigrationSet_EvaluateRecord<Situation>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<Situation>[] Container) {

        Q_MigrationSet_EvaluateRecord<Situation> success = new() {
            Mock = new() {
                Id = 1,
                Name = "",

            },
            Expectations = [],
        };
        Q_MigrationSet_EvaluateRecord<Situation> failAllCases = new() {
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
