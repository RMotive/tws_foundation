using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

using TWS_Business.Sets;

namespace TWS_Business.Quality.Sets;
public class Q_VehiculeModel : BQ_Set<VehiculeModel> {
    protected override Q_MigrationSet_EvaluateRecord<VehiculeModel>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<VehiculeModel>[] Container) {

        Q_MigrationSet_EvaluateRecord<VehiculeModel> success = new() {
            Mock = new() {
                Id = 1,
                Name = "Test name"
            },
            Expectations = [],
        };
        Q_MigrationSet_EvaluateRecord<VehiculeModel> failAllCases = new() {
            Mock = new() {
                Id = 0,                

            },
            Expectations = [
                (nameof(VehiculeModel.Id), [(new PointerValidator(), 3)]),
                (nameof(Truck.Status), [(new PointerValidator(), 3) ]),
                (nameof(VehiculeModel.Name), [(new RequiredValidator(), 1),(new LengthValidator(), 1)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}