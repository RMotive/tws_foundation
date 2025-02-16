using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;

namespace TWS_Business.Quality.Entities;
public class Q_LoadType : BQ_Entity<LoadType> {
    protected override Q_EntityEvaluation<LoadType>[] EvaluateFactory(Q_EntityEvaluation<LoadType>[] Container) {

        Q_EntityEvaluation<LoadType> success = new("Success") {
            Mock = new() {
                Id = 1,
                Name = ""
            },
            Expectations = [],
        };
        Q_EntityEvaluation<LoadType> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
                Name = ""
            },
            Expectations = [
                (nameof(LoadType.Id), [(new PointerValidator(), 3)]),
                (nameof(LoadType.Name), [(new RequiredValidator(), 1), (new LengthValidator(), 2)]),

            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}