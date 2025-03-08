using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities.Vehicules;

namespace TWS_Business.Quality.Entities;
public class Q_VehiculeModel : BQ_Entity<VehiculeModel> {
    protected override Q_EntityEvaluation<VehiculeModel>[] EvaluateFactory(Q_EntityEvaluation<VehiculeModel>[] Container) {

        Q_EntityEvaluation<VehiculeModel> success = new("Success") {
            Mock = new() {
                Id = 1,
                Name = "Test name"
            },
            Expectations = [],
        };
        Q_EntityEvaluation<VehiculeModel> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
            },
            Expectations = [
                (nameof(VehiculeModel.Id), [(new PointerValidator(), 3)]),
                (nameof(VehiculeModel.Name), [(new RequiredValidator(), 1),(new LengthValidator(), 1)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}