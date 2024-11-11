using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

using TWS_Business.Sets;

namespace TWS_Business.Quality.Sets;
public class Q_Employee : BQ_Set<Employee> {
    protected override Q_MigrationSet_EvaluateRecord<Employee>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<Employee>[] Container) {

        Q_MigrationSet_EvaluateRecord<Employee> success = new("Success") {
            Mock = new() {
                Id = 1,
                Status = 1,
                Identification = 1,


            },
            Expectations = [],
        };
        Q_MigrationSet_EvaluateRecord<Employee> failAllCases = new("All properties fail") {
            Mock = new() {
                Status = 0,
                Identification = 0,
            },
            Expectations = [
                (nameof(Employee.Id), [(new PointerValidator(), 3)]),
                (nameof(Employee.Identification), [(new PointerValidator(), 3)]),
                (nameof(Employee.Status), [(new PointerValidator(), 3)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}