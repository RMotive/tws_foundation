using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;

namespace TWS_Business.Quality.Entities;
public class Q_Status : BQ_Entity<Status> {
    protected override Q_EntityEvaluation<Status>[] EvaluateFactory(Q_EntityEvaluation<Status>[] Container) {

        Q_EntityEvaluation<Status> success = new("Success") {
            Mock = new() {
                Id = 1,
                Name = "",

            },
            Expectations = [],
        };
        Q_EntityEvaluation<Status> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
                Name = "Situation validation test, max lengh 25 characters",
                Description = ""
            },
            Expectations = [
                (nameof(Status.Id), [(new PointerValidator(), 3)]),
                (nameof(Status.Name), [(new LengthValidator(), 3)]),
            ],
        };



        Container = [.. Container, success, failAllCases];


        return Container;
    }
}