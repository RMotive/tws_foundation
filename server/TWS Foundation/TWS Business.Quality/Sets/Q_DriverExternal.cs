using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

using TWS_Business.Sets;

namespace TWS_Business.Quality.Sets;
public class Q_DriverExternal : BQ_Set<DriverExternal> {
    protected override Q_MigrationSet_EvaluateRecord<DriverExternal>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<DriverExternal>[] Container) {

        Q_MigrationSet_EvaluateRecord<DriverExternal> success = new("Success") {
            Mock = new() {
                Id = 1,
                Status = 0,
                Common = 0,
                Identification = 0
            },
            Expectations = [],
        };
        Q_MigrationSet_EvaluateRecord<DriverExternal> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
                Status = 0,
            },
            Expectations = [
                (nameof(DriverExternal.Id), [(new PointerValidator(), 3)]),
                (nameof(DriverExternal.Status), [(new PointerValidator(), 3)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}