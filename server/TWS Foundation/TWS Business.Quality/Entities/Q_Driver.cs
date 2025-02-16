using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;

namespace TWS_Business.Quality.Entities;
public class Q_Driver : BQ_Entity<Driver> {
    protected override Q_EntityEvaluation<Driver>[] EvaluateFactory(Q_EntityEvaluation<Driver>[] Container) {

        Q_EntityEvaluation<Driver> success = new("Success") {
            Mock = new() {
                Id = 1,
                Status = 0,
                Employee = 0,
                DriverType = "",
                Common = 0
            },
            Expectations = [],
        };
        Q_EntityEvaluation<Driver> failAllCases = new("All properties fail") {
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