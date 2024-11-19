using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

using TWS_Business.Sets;

namespace TWS_Business.Quality.Sets;
public class Q_Manufacturer : BQ_Set<Manufacturer> {
    protected override Q_MigrationSet_EvaluateRecord<Manufacturer>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<Manufacturer>[] Container) {

        Q_MigrationSet_EvaluateRecord<Manufacturer> success = new("Success") {
            Mock = new() {
                Id = 1,
                Name = "",
            },
            Expectations = [],
        };
        Q_MigrationSet_EvaluateRecord<Manufacturer> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
            },
            Expectations = [
                (nameof(Manufacturer.Id), [(new PointerValidator(), 3)]),
                (nameof(Manufacturer.Name), [(new RequiredValidator(), 1),(new LengthValidator(), 1)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}