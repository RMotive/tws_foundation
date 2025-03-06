using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities.Trailers;

namespace TWS_Business.Quality.Entities;
public class Q_TrailerType : BQ_Entity<Trailer_Type> {
    protected override Q_EntityEvaluation<Trailer_Type>[] EvaluateFactory(Q_EntityEvaluation<Trailer_Type>[] Container) {

        Q_EntityEvaluation<Trailer_Type> success = new("Success") {
            Mock = new() {
                Id = 1,
                Size = "Test size"
            },
            Expectations = [],
        };
        Q_EntityEvaluation<Trailer_Type> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
                Class = new Trailer_Class { Id = 0 }
            },
            Expectations = [
                (nameof(Trailer_Type.Status), [(new PointerValidator(), 3) ]),
                (nameof(Trailer_Type.Id), [(new PointerValidator(), 3)]),
                (nameof(Trailer_Type.Size), [(new RequiredValidator(), 1),(new LengthValidator(), 1)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}