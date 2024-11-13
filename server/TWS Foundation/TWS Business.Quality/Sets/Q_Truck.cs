using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

using TWS_Business.Sets;

namespace TWS_Business.Quality.Sets;
public class Q_Truck : BQ_Set<Truck> {
    protected override Q_MigrationSet_EvaluateRecord<Truck>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<Truck>[] Container) {
        Q_MigrationSet_EvaluateRecord<Truck> success = new("Success") {
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
        Q_MigrationSet_EvaluateRecord<Truck> failAllCases = new("All properties fail") {
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
                (nameof(Truck.Vin), [(new RequiredValidator(), 1),(new LengthValidator(),2)]),
                (nameof(Truck.Status), [(new PointerValidator(), 3) ]),

            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}