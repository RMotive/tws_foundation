using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities.Employees;

namespace TWS_Business.Quality.Entities.Employees;

public class Q_Employee 
    : BQ_Entity<Employee> {
    protected override Q_EntityEvaluation<Employee>[] EvaluateFactory(Q_EntityEvaluation<Employee>[] Container) {

        Q_EntityEvaluation<Employee> success = new("Success") {
            Mock = new() {
                Id = 1,
                Status = 1,
                Identification = 1,


            },
            Expectations = [],
        };
        Q_EntityEvaluation<Employee> failAllCases = new("All properties fail") {
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