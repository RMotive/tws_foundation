using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;

namespace TWS_Business.Quality.Entities;
public class Q_Manufacturer : BQ_Entity<Manufacturer> {
    protected override Q_EntityEvaluation<Manufacturer>[] EvaluateFactory(Q_EntityEvaluation<Manufacturer>[] Container) {

        Q_EntityEvaluation<Manufacturer> success = new("Success") {
            Mock = new() {
                Id = 1,
                Name = "",
            },
            Expectations = [],
        };
        Q_EntityEvaluation<Manufacturer> failAllCases = new("All properties fail") {
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