using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;

namespace TWS_Business.Quality.Entities;
public class Q_Truck : BQ_Entity<Truck> {
    protected override Q_EntityEvaluation<Truck>[] EvaluateFactory(Q_EntityEvaluation<Truck>[] Container) {
        Q_EntityEvaluation<Truck> success = new("Success") {
            Mock = new() {
                Id = 1,
                Common = 1,
                Model = 3,
                Motor = "",
                Maintenance = 4,
                Insurance = 5,
                Status = 1
            },
            Expectations = [],
        };
        Q_EntityEvaluation<Truck> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = -1,
                Common = 0,
                Model = 0,
                Carrier = 0,
                Vin = "",
                Status = 0
            },
            Expectations = [
                (nameof(Truck.Id), [(new PointerValidator(), 3) ]),
                (nameof(Truck.Vin), [(new RequiredValidator(), 1),(new LengthValidator(), 2)]),
                (nameof(Truck.Status), [(new PointerValidator(), 3) ]),

            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}