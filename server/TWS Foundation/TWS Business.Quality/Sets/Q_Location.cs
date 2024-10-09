using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

using TWS_Business.Sets;

namespace TWS_Business.Quality.Sets;
public class Q_Location : BQ_Set<Location> {
    protected override Q_MigrationSet_EvaluateRecord<Location>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<Location>[] Container) {

        Q_MigrationSet_EvaluateRecord<Location> success = new() {
            Mock = new() {
                Id = 1,
                Name = "",
                Address = 1,
                Status = 1

            },
            Expectations = [],
        };
        Q_MigrationSet_EvaluateRecord<Location> failAllCases = new() {
            Mock = new() {
                Id = 0,
                Name = "",
                Address = 0,
                Status = 0,
            },
            Expectations = [
                (nameof(Location.Id), [(new PointerValidator(), 3)]),
                (nameof(Location.Name), [(new RequiredValidator(), 1), (new LengthValidator(), 2)]),
                (nameof(Location.Status), [(new PointerValidator(true), 3)])
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}