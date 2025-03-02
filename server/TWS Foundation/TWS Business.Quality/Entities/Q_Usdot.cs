using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;

namespace TWS_Business.Quality.Entities;
public class Q_Usdot : BQ_Entity<USDOT> {
    protected override Q_EntityEvaluation<USDOT>[] EvaluateFactory(Q_EntityEvaluation<USDOT>[] Container) {

        Q_EntityEvaluation<USDOT> success = new("Success") {
            Mock = new() {
                Id = 1,
                Status = new Status { Id = 1 },
                MC = "",
                SCAC = ""
            },
            Expectations = [],
        };
        Q_EntityEvaluation<USDOT> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = -1,
                Status = new Status { Id = -1 },
                MC = "",
                SCAC = ""
            },
            Expectations = [
                (nameof(USDOT.Id), [(new PointerValidator(), 3) ]),
                (nameof(USDOT.MC), [(new RequiredValidator(), 1), (new LengthValidator(),2)]),
                (nameof(USDOT.SCAC), [(new RequiredValidator(), 1), (new LengthValidator(), 2)]),
                (nameof(USDOT.Status), [(new PointerValidator(), 3) ])
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}