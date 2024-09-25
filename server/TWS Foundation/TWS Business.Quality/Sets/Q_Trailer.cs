using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

using TWS_Business.Sets;

namespace TWS_Business.Quality.Sets;
public class Q_Trailer : BQ_Set<Trailer> {
    protected override Q_MigrationSet_EvaluateRecord<Trailer>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<Trailer>[] Container) {

        Q_MigrationSet_EvaluateRecord<Trailer> success = new() {
            Mock = new() {
                Id = 1,
                Common = 0,
                Manufacturer = 0,
                Maintenance = 0,
                Status = 0
            },
            Expectations = [],
        };
        Q_MigrationSet_EvaluateRecord<Trailer> failAllCases = new() {
            Mock = new() {
                Id = 0,
                Common = 0,
                Manufacturer = 0,
                Carrier = 0,
                Status = 0

            },
            Expectations = [
                (nameof(Trailer.Id), [(new PointerValidator(), 3)]),
                (nameof(Trailer.Manufacturer), [(new PointerValidator(true), 3)]),
                (nameof(Trailer.Carrier), [(new PointerValidator(), 3)]),
                (nameof(Trailer.Status), [(new PointerValidator(true), 3)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}