using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities.Trucks;

namespace TWS_Business.Quality.Entities;
public class Q_TruckInventory : BQ_Entity<TruckEntry> {
    protected override Q_EntityEvaluation<TruckEntry>[] EvaluateFactory(Q_EntityEvaluation<TruckEntry>[] Container) {

        Q_EntityEvaluation<TruckEntry> success = new("Success") {
            Mock = new() {
                Id = 1,
                Section = new TWS_Business.Entities.Section {
                    Id = 0
                },
            },
            Expectations = [],
        };
        Q_EntityEvaluation<TruckEntry> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
            },
            Expectations = [
                (nameof(TruckEntry.Id), [(new PointerValidator(), 3)]),
                (nameof(TruckEntry.Section), [(new PointerValidator(), 3)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}