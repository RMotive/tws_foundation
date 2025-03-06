using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities.Insurances;

namespace TWS_Business.Quality.Entities;
public class Q_Insurance : BQ_Entity<Insurance> {
    protected override Q_EntityEvaluation<Insurance>[] EvaluateFactory(Q_EntityEvaluation<Insurance>[] Container) {

        Q_EntityEvaluation<Insurance> success = new("Success") {
            Mock = new() {
                Id = 1,
                Policy = "",
                Country = "",
                Expiration = DateOnly.FromDateTime(new DateTime()),

            },
            Expectations = [],
        };
        Q_EntityEvaluation<Insurance> failAllCases = new("All properties fail") {
            Mock = new(),
            Expectations = [
                (nameof(Insurance.Id), [(new PointerValidator(), 3)]),
                (nameof(Insurance.Policy), [(new LengthValidator(), 2)]),
                (nameof(Insurance.Country), [(new LengthValidator(), 2)]),
                (nameof(Insurance.Status), [(new PointerValidator(true), 3)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}