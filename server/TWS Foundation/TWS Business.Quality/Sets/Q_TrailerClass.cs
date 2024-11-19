using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

using TWS_Business.Sets;

namespace TWS_Business.Quality.Sets;
public class Q_TrailerClass : BQ_Set<TrailerClass> {
    protected override Q_MigrationSet_EvaluateRecord<TrailerClass>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<TrailerClass>[] Container) {

        Q_MigrationSet_EvaluateRecord<TrailerClass> success = new("Success") {
            Mock = new() {
                Id = 1,
                Name = "",
            },
            Expectations = [],
        };
        Q_MigrationSet_EvaluateRecord<TrailerClass> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,

            },
            Expectations = [
                (nameof(TrailerClass.Id), [(new PointerValidator(), 3)]),
                (nameof(TrailerClass.Name), [(new RequiredValidator(), 1), (new LengthValidator(), 1)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}