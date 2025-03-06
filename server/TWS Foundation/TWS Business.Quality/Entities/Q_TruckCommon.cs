using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;
using TWS_Business.Entities.Trucks;

namespace TWS_Business.Quality.Entities;
public class Q_TruckCommon : BQ_Entity<Truck_Common> {
    protected override Q_EntityEvaluation<Truck_Common>[] EvaluateFactory(Q_EntityEvaluation<Truck_Common>[] Container) {

        Q_EntityEvaluation<Truck_Common> success = new("Success") {
            Mock = new() {
                Id = 1,
                Economic = "",
                Situation = new Situation {
                    Id = 1,
                }

            },
            Expectations = [],
        };
        Q_EntityEvaluation<Truck_Common> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
                Economic = "",
            },
            Expectations = [
                (nameof(Truck_Common.Id), [(new PointerValidator(), 3)]),
                (nameof(Truck_Common.Economic), [(new RequiredValidator(), 1), (new LengthValidator(),2)]),
                (nameof(Truck_Common.Status), [(new PointerValidator(), 3)]),

            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}