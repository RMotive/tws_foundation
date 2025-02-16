using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;

namespace TWS_Business.Quality.Entities;
public class Q_Usdot : BQ_Entity<Usdot> {
    protected override Q_EntityEvaluation<Usdot>[] EvaluateFactory(Q_EntityEvaluation<Usdot>[] Container) {

        Q_EntityEvaluation<Usdot> success = new("Success") {
            Mock = new() {
                Id = 1,
                Status = 1,
                Mc = "",
                Scac = ""
            },
            Expectations = [],
        };
        Q_EntityEvaluation<Usdot> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = -1,
                Status = -1,
                Mc = "",
                Scac = ""
            },
            Expectations = [
                (nameof(Usdot.Id), [(new PointerValidator(), 3) ]),
                (nameof(Usdot.Mc), [(new RequiredValidator(), 1), (new LengthValidator(),2)]),
                (nameof(Usdot.Scac), [(new RequiredValidator(), 1), (new LengthValidator(), 2)]),
                (nameof(Usdot.Status), [(new PointerValidator(), 3) ])
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}