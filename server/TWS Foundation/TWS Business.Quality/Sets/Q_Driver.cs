using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

using TWS_Business.Sets;

namespace TWS_Business.Quality.Sets;
public class Q_Driver : BQ_Set<Driver> {
    protected override Q_MigrationSet_EvaluateRecord<Driver>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<Driver>[] Container) {

        Q_MigrationSet_EvaluateRecord<Driver> success = new("Success") {
            Mock = new() {
                Id = 1,
                Status = 0,
                Employee = 0,
                DriverType = "",
                Common = 0
            },
            Expectations = [],
        };
        Q_MigrationSet_EvaluateRecord<Driver> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
                Status = 0,
            },
            Expectations = [
                (nameof(Driver.Id), [(new PointerValidator(), 3)]),
                (nameof(Driver.Status), [(new PointerValidator(true), 3)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}