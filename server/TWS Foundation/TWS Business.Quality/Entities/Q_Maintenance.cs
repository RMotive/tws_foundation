using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;

namespace TWS_Business.Quality.Entities;
public class Q_Maintenance : BQ_Entity<Maintenance> {
    protected override Q_EntityEvaluation<Maintenance>[] EvaluateFactory(Q_EntityEvaluation<Maintenance>[] Container) {

        Q_EntityEvaluation<Maintenance> success = new("Success") {
            Mock = new() {
                Id = 1,
                Anual = DateOnly.FromDateTime(new DateTime()),
                Trimestral = DateOnly.FromDateTime(new DateTime()),
            },
            Expectations = [],
        };
        Q_EntityEvaluation<Maintenance> failAllCases = new("All properties fail") {
            Mock = new(),
            Expectations = [
                (nameof(Maintenance.Id), [(new PointerValidator(), 3)]),
                (nameof(Maintenance.Status), [(new PointerValidator(true), 3)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}