using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

using TWS_Business.Sets;

namespace TWS_Business.Quality.Sets;
public class Q_Usdot : BQ_Set<Usdot> {
    protected override Q_MigrationSet_EvaluateRecord<Usdot>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<Usdot>[] Container) {

        Q_MigrationSet_EvaluateRecord<Usdot> success = new("Success") {
            Mock = new() {
                Id = 1,
                Status = 1,
                Mc = "",
                Scac = ""
            },
            Expectations = [],
        };
        Q_MigrationSet_EvaluateRecord<Usdot> failAllCases = new("All properties fail") {
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