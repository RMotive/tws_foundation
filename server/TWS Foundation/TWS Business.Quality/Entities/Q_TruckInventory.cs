using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;

namespace TWS_Business.Quality.Entities;
public class Q_TruckInventory : BQ_Entity<TruckInventory> {
    protected override Q_EntityEvaluation<TruckInventory>[] EvaluateFactory(Q_EntityEvaluation<TruckInventory>[] Container) {

        Q_EntityEvaluation<TruckInventory> success = new("Success") {
            Mock = new() {
                Id = 1,
                Section = 0,

            },
            Expectations = [],
        };
        Q_EntityEvaluation<TruckInventory> failAllCases = new("All properties fail") {
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