using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;

namespace TWS_Business.Quality.Entities;
public class Q_TrailerExternal : BQ_Entity<TrailerExternal> {
    protected override Q_EntityEvaluation<TrailerExternal>[] EvaluateFactory(Q_EntityEvaluation<TrailerExternal>[] Container) {

        Q_EntityEvaluation<TrailerExternal> success = new("Success") {
            Mock = new() {
                Id = 1,
                Status = 1,
                Common = 1
            },
            Expectations = [],
        };
        Q_EntityEvaluation<TrailerExternal> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
                Status = 0,
                Common = 0,
                Carrier = "",
                MxPlate = ""
            },
            Expectations = [
                (nameof(TrailerExternal.Id), [(new PointerValidator(), 3)]),
                (nameof(TrailerExternal.Status), [(new PointerValidator(), 3)]),
                (nameof(TrailerExternal.Carrier), [(new LengthValidator(), 2)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}