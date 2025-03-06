using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;

namespace TWS_Business.Quality.Entities;
public class Q_Identification : BQ_Entity<Identification> {
    protected override Q_EntityEvaluation<Identification>[] EvaluateFactory(Q_EntityEvaluation<Identification>[] Container) {

        Q_EntityEvaluation<Identification> success = new("Success") {
            Mock = new() {
                Id = 1,
                Status = new Status { Id = 1 },
                Name = "",
                Lastname = "",
            },
            Expectations = [],
        };
        Q_EntityEvaluation<Identification> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
                Status = new Status { Id = 0 },
            },
            Expectations = [
                (nameof(Identification.Id), [(new PointerValidator(), 3)]),
                (nameof(Identification.Name), [(new RequiredValidator(), 1), (new LengthValidator(), 1)]),
                (nameof(Identification.Lastname), [(new RequiredValidator(), 1), (new LengthValidator(), 1)]),
                (nameof(Identification.Status), [(new PointerValidator(true), 3)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}