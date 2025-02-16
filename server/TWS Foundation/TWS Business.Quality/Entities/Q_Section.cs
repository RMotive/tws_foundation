using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;

namespace TWS_Business.Quality.Entities;
public class Q_Section : BQ_Entity<Section> {
    protected override Q_EntityEvaluation<Section>[] EvaluateFactory(Q_EntityEvaluation<Section>[] Container) {

        Q_EntityEvaluation<Section> success = new("Success") {
            Mock = new() {
                Id = 1,
                Name = "",
                Yard = 0,
                Status = 0

            },
            Expectations = [],
        };
        Q_EntityEvaluation<Section> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
                Name = "",
                Yard = 0,
                Status = 0
            },
            Expectations = [
                (nameof(Section.Id), [(new PointerValidator(), 3)]),
                (nameof(Section.Name), [(new LengthValidator(), 2)]),
                (nameof(Section.Yard), [(new PointerValidator(true), 3)]),
                (nameof(Section.Status), [(new PointerValidator(true), 3)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}