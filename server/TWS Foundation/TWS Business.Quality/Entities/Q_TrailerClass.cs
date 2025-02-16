using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;

namespace TWS_Business.Quality.Entities;
public class Q_TrailerClass : BQ_Entity<TrailerClass> {
    protected override Q_EntityEvaluation<TrailerClass>[] EvaluateFactory(Q_EntityEvaluation<TrailerClass>[] Container) {

        Q_EntityEvaluation<TrailerClass> success = new("Success") {
            Mock = new() {
                Id = 1,
                Name = "",
            },
            Expectations = [],
        };
        Q_EntityEvaluation<TrailerClass> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,

            },
            Expectations = [
                (nameof(TrailerClass.Id), [(new PointerValidator(), 3)]),
                (nameof(TrailerClass.Name), [(new RequiredValidator(), 1), (new LengthValidator(), 1)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}