using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;
using TWS_Business.Entities.Insurances;
using TWS_Business.Entities.Maintenances;
using TWS_Business.Entities.Trucks;
using TWS_Business.Entities.Vehicules;
using TWS_Business.Entities.Vehicules.Trucks;

namespace TWS_Business.Quality.Entities;
public class Q_Truck : BQ_Entity<Truck> {
    protected override Q_EntityEvaluation<Truck>[] EvaluateFactory(Q_EntityEvaluation<Truck>[] Container) {
        Q_EntityEvaluation<Truck> success = new("Success") {
            Mock = new() {
                Id = 1,
                Common = new Truck_Common {
                    Id = 1,
                    Status = new Status {
                        Id = 1,
                    }
                },
                Model = new VehiculeModel {
                    Id = 3,
                },
                Maintenance = new Maintenance {
                    Id = 4,
                },
                Insurance = new Insurance {
                    Id = 5,
                },
            },
            Expectations = [],
        };
        Q_EntityEvaluation<Truck> failAllCases = new("All properties fail") {
            Mock = new(),
            Expectations = [
                (nameof(Truck.Id), [(new PointerValidator(), 3) ]),
                (nameof(Truck.VIN), [(new RequiredValidator(), 1),(new LengthValidator(), 2)]),

            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}