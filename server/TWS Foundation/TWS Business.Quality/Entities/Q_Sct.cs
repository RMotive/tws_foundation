using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities.SCTs;

namespace TWS_Business.Quality.Entities;
public class Q_Sct : BQ_Entity<SCT> {
    protected override Q_EntityEvaluation<SCT>[] EvaluateFactory(Q_EntityEvaluation<SCT>[] Container) {

        Q_EntityEvaluation<SCT> success = new("Success") {
            Mock = new() {
                Type = "Type06",
                Number = "NumberSCTTesting_valueT00",
                Configuration = "ConfT15",

            },
            Expectations = [],
        };
        Q_EntityEvaluation<SCT> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
                Type = "",
                Number = "",
                Configuration = "",
            },
            Expectations = [
                (nameof(SCT.Id), [(new PointerValidator(), 3)]),
                (nameof(SCT.Type), [(new RequiredValidator(), 1), (new LengthValidator(), 2)]),
                (nameof(SCT.Number), [(new RequiredValidator(), 1), (new LengthValidator(), 2)]),
                (nameof(SCT.Configuration), [(new RequiredValidator(), 1), (new LengthValidator(), 2)]),
                (nameof(SCT.Status), [(new PointerValidator(), 3)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}
