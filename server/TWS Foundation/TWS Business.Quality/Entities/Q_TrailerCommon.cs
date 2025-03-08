using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;
using TWS_Business.Entities.Drivers;
using TWS_Business.Entities.Trailers;
using TWS_Business.Entities.Vehicules;
using TWS_Business.Entities.Vehicules.Trailers;

namespace TWS_Business.Quality.Entities;
public class Q_TrailerCommon : BQ_Entity<Trailer_Common> {
    protected override Q_EntityEvaluation<Trailer_Common>[] EvaluateFactory(Q_EntityEvaluation<Trailer_Common>[] Container) {

        Q_EntityEvaluation<Trailer_Common> success = new("Success") {
            Mock = new() {
                Id = 1,
                Type = new Trailer_Type { Id = 1 },
                Situation = new Situation { Id = 1 },

            },
            Expectations = [],
        };
        Q_EntityEvaluation<Trailer_Common> failAllCases = new("All properties fail") {
            Mock = new(),
            Expectations = [
                (nameof(Trailer_Common.Id), [(new PointerValidator(), 3)]),
                (nameof(Trailer_Common.Economic), [(new RequiredValidator(), 1), (new LengthValidator(),2)]),
                (nameof(Driver_Common.Status), [(new PointerValidator(true), 3) ])
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}