using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

using TWS_Business.Sets;

namespace TWS_Business.Quality.Sets;
public class Q_TruckExternal : BQ_Set<TruckExternal> {
    protected override Q_MigrationSet_EvaluateRecord<TruckExternal>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<TruckExternal>[] Container) {

        Q_MigrationSet_EvaluateRecord<TruckExternal> success = new() {
            Mock = new() {
                Id = 1,
                Status = 1,
                Common = 1
            },
            Expectations = [],
        };
        Q_MigrationSet_EvaluateRecord<TruckExternal> failAllCases = new() {
            Mock = new() {
                Id = 0,
                Status = 0,
                Common = 0,
                Carrier = "",
                MxPlate = ""
            },
            Expectations = [
                (nameof(TruckExternal.Id), [(new PointerValidator(), 3)]),
                (nameof(TruckExternal.Status), [(new PointerValidator(), 3)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}