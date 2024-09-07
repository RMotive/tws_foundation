using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

using TWS_Business.Sets;

namespace TWS_Business.Quality.Sets;
public class Q_LoadType : BQ_Set<LoadType> {
    protected override Q_MigrationSet_EvaluateRecord<LoadType>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<LoadType>[] Container) {

        Q_MigrationSet_EvaluateRecord<LoadType> success = new() {
            Mock = new() {
                Id = 1,
                Name = ""
            },
            Expectations = [],
        };
        Q_MigrationSet_EvaluateRecord<LoadType> failAllCases = new() {
            Mock = new() {
                Id = 0,
                Name = ""
            },
            Expectations = [
                (nameof(LoadType.Id), [(new PointerValidator(), 3)]),
                (nameof(LoadType.Name), [(new LengthValidator(), 2)]),

            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}