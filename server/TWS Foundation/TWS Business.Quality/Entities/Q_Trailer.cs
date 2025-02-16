using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;

namespace TWS_Business.Quality.Entities;
public class Q_Trailer : BQ_Entity<Trailer> {
    protected override Q_EntityEvaluation<Trailer>[] EvaluateFactory(Q_EntityEvaluation<Trailer>[] Container) {

        Q_EntityEvaluation<Trailer> success = new("Success") {
            Mock = new() {
                Id = 1,
                Common = 0,
                Maintenance = 0,
                Status = 0
            },
            Expectations = [],
        };
        Q_EntityEvaluation<Trailer> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
                Status = 0

            },
            Expectations = [
                (nameof(Trailer.Id), [(new PointerValidator(), 3)]),
                (nameof(Trailer.Status), [(new PointerValidator(), 3)])
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}