using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;

namespace TWS_Business.Quality.Entities;
public class Q_Location : BQ_Entity<Location> {
    protected override Q_EntityEvaluation<Location>[] EvaluateFactory(Q_EntityEvaluation<Location>[] Container) {

        Q_EntityEvaluation<Location> success = new("Success") {
            Mock = new() {
                Id = 1,
                Name = "",
                Address = new Address {
                    Id = 1,
                },
                Status = new Status {
                    Id = 1,
                }

            },
            Expectations = [],
        };
        Q_EntityEvaluation<Location> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
                Name = "",
                Address = new Address {
                    Id = 1,
                },
                Status = new Status {
                    Id = 1,
                },
            },
            Expectations = [
                (nameof(Location.Id), [(new PointerValidator(), 3)]),
                (nameof(Location.Name), [(new RequiredValidator(), 1), (new LengthValidator(), 2)]),
                (nameof(Location.Status), [(new PointerValidator(true), 3)])
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}