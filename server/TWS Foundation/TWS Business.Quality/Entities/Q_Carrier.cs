using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;
using TWS_Business.Entities.Approaches;
using TWS_Business.Entities.Carriers;

namespace TWS_Business.Quality.Entities;
public class Q_Carrier : BQ_Entity<Carrier> {
    protected override Q_EntityEvaluation<Carrier>[] EvaluateFactory(Q_EntityEvaluation<Carrier>[] Container) {
        PointerValidator pointer = new(true);

        Q_EntityEvaluation<Carrier> success = new("Success") {
            Mock = new() {
                Id = 1,
                Name = "",
                Status = new Status {
                    Id = 1,
                },
                Approach = new Approach {
                    Id = 1,
                },
                Address = new Address {
                    Id = 1,
                }

            },
            Expectations = [],
        };
        Q_EntityEvaluation<Carrier> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = -1,
                Status = new(),
            },
            Expectations = [
                (nameof(Carrier.Id), [(new PointerValidator(), 3) ]),
                (nameof(Carrier.Name), [(new RequiredValidator(), 1)]),
                (nameof(Carrier.Status), [(pointer, 3) ])
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}