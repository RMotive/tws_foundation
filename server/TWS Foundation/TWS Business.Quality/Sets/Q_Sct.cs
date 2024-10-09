using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

using TWS_Business.Sets;

namespace TWS_Business.Quality.Sets;
public class Q_Sct : BQ_Set<Sct> {
    protected override Q_MigrationSet_EvaluateRecord<Sct>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<Sct>[] Container) {

        Q_MigrationSet_EvaluateRecord<Sct> success = new() {
            Mock = new() {
                Type = "Type06",
                Number = "NumberSCTTesting_valueT00",
                Configuration = "ConfT15",

            },
            Expectations = [],
        };
        Q_MigrationSet_EvaluateRecord<Sct> failAllCases = new() {
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
