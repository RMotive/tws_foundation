using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

using TWS_Business.Sets;

namespace TWS_Business.Quality.Sets;
public class Q_TruckInventory : BQ_Set<TruckInventory> {
    protected override Q_MigrationSet_EvaluateRecord<TruckInventory>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<TruckInventory>[] Container) {

        Q_MigrationSet_EvaluateRecord<TruckInventory> success = new("Success") {
            Mock = new() {
                Id = 1,
                Section = 0,

            },
            Expectations = [],
        };
        Q_MigrationSet_EvaluateRecord<TruckInventory> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
                Section = -1,

            },
            Expectations = [
                (nameof(TruckInventory.Id), [(new PointerValidator(), 3)]),
                (nameof(TruckInventory.Section), [(new PointerValidator(), 3)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}