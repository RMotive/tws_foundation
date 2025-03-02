using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;

namespace TWS_Business.Quality.Entities;
public class Q_Plate : BQ_Entity<Plate> {
    protected override Q_EntityEvaluation<Plate>[] EvaluateFactory(Q_EntityEvaluation<Plate>[] Container) {

        Q_EntityEvaluation<Plate> success = new("Succes") {
            Mock = new() {
                Id = 1,
                Identifier = "",
                State = "",
                Country = "",
                Expiration = DateOnly.FromDateTime(new DateTime()),
                Truck = new Truck { Id = 1 }
            },
            Expectations = [],
        };
        Q_EntityEvaluation<Plate> failAllCases = new("All properties fail") {
            Mock = new(),
            Expectations = [
                (nameof(Plate.Id), [(new PointerValidator(), 3)]),
                (nameof(Plate.Identifier), [(new LengthValidator(), 2)]),
                (nameof(Plate.Country), [(new LengthValidator(), 2)]),
                (nameof(Plate.Status), [(new PointerValidator(true), 3)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}