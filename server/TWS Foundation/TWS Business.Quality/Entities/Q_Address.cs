using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;

namespace TWS_Business.Quality.Entities;
public class Q_Address : BQ_Entity<Address> {
    protected override Q_EntityEvaluation<Address>[] EvaluateFactory(Q_EntityEvaluation<Address>[] Container) {

        Q_EntityEvaluation<Address> success = new("Success") {
            Mock = new() {
                Id = 1,
                Country = "",

            },
            Expectations = [],
        };
        Q_EntityEvaluation<Address> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
                Country = "",

            },
            Expectations = [
                (nameof(Address.Id), [(new PointerValidator(), 3)]),
                (nameof(Address.Country), [(new RequiredValidator(), 1),(new LengthValidator(), 2)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}