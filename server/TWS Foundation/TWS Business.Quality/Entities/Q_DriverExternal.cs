using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities.Drivers;

namespace TWS_Business.Quality.Entities;
public class Q_DriverExternal : BQ_Entity<DriverExternal> {
    protected override Q_EntityEvaluation<DriverExternal>[] EvaluateFactory(Q_EntityEvaluation<DriverExternal>[] Container) {

        Q_EntityEvaluation<DriverExternal> success = new("Success") {
            Mock = new() {
                Id = 1,
            },
            Expectations = [],
        };
        Q_EntityEvaluation<DriverExternal> failAllCases = new("All properties fail") {
            Mock = new(),
            Expectations = [
                (nameof(DriverExternal.Id), [(new PointerValidator(), 3)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}