using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

using TWS_Business.Sets;

namespace TWS_Business.Quality.Sets;
public class Q_TrailerType : BQ_Set<TrailerType> {
    protected override Q_MigrationSet_EvaluateRecord<TrailerType>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<TrailerType>[] Container) {

        Q_MigrationSet_EvaluateRecord<TrailerType> success = new("Success") {
            Mock = new() {
                Id = 1,
                Size = "Test size"
            },
            Expectations = [],
        };
        Q_MigrationSet_EvaluateRecord<TrailerType> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
                TrailerClass = 0

            },
            Expectations = [
                (nameof(TrailerType.Status), [(new PointerValidator(), 3) ]),
                (nameof(TrailerType.Id), [(new PointerValidator(), 3)]),
                (nameof(TrailerType.Size), [(new RequiredValidator(), 1),(new LengthValidator(), 1)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}