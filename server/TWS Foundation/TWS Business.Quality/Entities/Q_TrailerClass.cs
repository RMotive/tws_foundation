using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities.Trailers;

namespace TWS_Business.Quality.Entities;
public class Q_TrailerClass : BQ_Entity<Trailer_Class> {
    protected override Q_EntityEvaluation<Trailer_Class>[] EvaluateFactory(Q_EntityEvaluation<Trailer_Class>[] Container) {

        Q_EntityEvaluation<Trailer_Class> success = new("Success") {
            Mock = new() {
                Id = 1,
                Name = "",
            },
            Expectations = [],
        };
        Q_EntityEvaluation<Trailer_Class> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,

            },
            Expectations = [
                (nameof(Trailer_Class.Id), [(new PointerValidator(), 3)]),
                (nameof(Trailer_Class.Name), [(new RequiredValidator(), 1), (new LengthValidator(), 1)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}