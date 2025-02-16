using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;

namespace TWS_Business.Quality.Entities;
public class Q_Sct : BQ_Entity<Sct> {
    protected override Q_EntityEvaluation<Sct>[] EvaluateFactory(Q_EntityEvaluation<Sct>[] Container) {

        Q_EntityEvaluation<Sct> success = new("Success") {
            Mock = new() {
                Type = "Type06",
                Number = "NumberSCTTesting_valueT00",
                Configuration = "ConfT15",

            },
            Expectations = [],
        };
        Q_EntityEvaluation<Sct> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
                Type = "",
                Number = "",
                Configuration = "",
            },
            Expectations = [
                (nameof(Sct.Id), [(new PointerValidator(), 3)]),
                (nameof(Sct.Type), [(new RequiredValidator(), 1), (new LengthValidator(), 2)]),
                (nameof(Sct.Number), [(new RequiredValidator(), 1), (new LengthValidator(), 2)]),
                (nameof(Sct.Configuration), [(new RequiredValidator(), 1), (new LengthValidator(), 2)]),
                (nameof(Sct.Status), [(new PointerValidator(), 3)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}
