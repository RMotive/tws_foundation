using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;
using TWS_Business.Entities.Trucks;
using TWS_Business.Entities.Vehicules;
using TWS_Business.Entities.Vehicules.Trucks;

namespace TWS_Business.Quality.Entities;
public class Q_TruckExternal : BQ_Entity<TruckExternal> {
    protected override Q_EntityEvaluation<TruckExternal>[] EvaluateFactory(Q_EntityEvaluation<TruckExternal>[] Container) {

        Q_EntityEvaluation<TruckExternal> success = new("Success") {
            Mock = new() {
                Id = 1,
                Common = new Truck_Common {
                    Id = 1,
                    Status = new Status {
                        Id  =1,
                    }
                }
            },
            Expectations = [],
        };
        Q_EntityEvaluation<TruckExternal> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
                Carrier = "",
                MxPlate = ""
            },
            Expectations = [
                (nameof(TruckExternal.Id), [(new PointerValidator(), 3)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}