using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

using TWS_Business.Sets;

namespace TWS_Business.Quality.Sets;
public class Q_Carrier : BQ_Set<Carrier> {
    protected override Q_MigrationSet_EvaluateRecord<Carrier>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<Carrier>[] Container) {
        PointerValidator pointer = new(true);

        Q_MigrationSet_EvaluateRecord<Carrier> success = new() {
            Mock = new() {
                Id = 1,
                Name = "",
                Status = 1,
                Approach = 1,
                Address = 1
               
            },
            Expectations = [],
        };
        Q_MigrationSet_EvaluateRecord<Carrier> failAllCases = new() {
            Mock = new() {
                Id = -1,
                Name = "",
                Status = 0,
                Approach = 0,
                Address = 0
            },
            Expectations = [
                (nameof(Carrier.Id), [(new PointerValidator(), 3) ]),
                (nameof(Carrier.Name), [(new RequiredValidator(), 1), (new LengthValidator(),2)]),
                (nameof(Carrier.Approach), [(pointer, 3)]),
                (nameof(Carrier.Address), [(pointer, 3) ]),
                (nameof(Carrier.Status), [(pointer, 3) ])
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}