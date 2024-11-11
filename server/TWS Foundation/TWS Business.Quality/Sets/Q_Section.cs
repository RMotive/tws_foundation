using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

using TWS_Business.Sets;

namespace TWS_Business.Quality.Sets;
public class Q_Section : BQ_Set<Section> {
    protected override Q_MigrationSet_EvaluateRecord<Section>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<Section>[] Container) {

        Q_MigrationSet_EvaluateRecord<Section> success = new("Success") {
            Mock = new() {
                Id = 1,
                Name = "",
                Yard = 0,
                Status = 0

            },
            Expectations = [],
        };
        Q_MigrationSet_EvaluateRecord<Section> failAllCases = new("All properties fail") {
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