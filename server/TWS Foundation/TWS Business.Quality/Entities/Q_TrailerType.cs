using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;

namespace TWS_Business.Quality.Entities;
public class Q_TrailerType : BQ_Entity<TrailerType> {
    protected override Q_EntityEvaluation<TrailerType>[] EvaluateFactory(Q_EntityEvaluation<TrailerType>[] Container) {

        Q_EntityEvaluation<TrailerType> success = new("Success") {
            Mock = new() {
                Id = 1,
                Size = "Test size"
            },
            Expectations = [],
        };
        Q_EntityEvaluation<TrailerType> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
                Class = new TrailerClass { Id = 0 }
            },
            Expectations = [
                (nameof(TrailerType.Status), [(new PointerValidator(), 3) ]),
                (nameof(TrailerType.Id), [(new PointerValidator(), 3)]),
                (nameof(TrailerType.Size), [(new RequiredValidator(), 1),(new LengthValidator(), 1)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}