using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;

namespace TWS_Business.Quality.Entities;
public class Q_YardLog : BQ_Entity<YardLog> {
    protected override Q_EntityEvaluation<YardLog>[] EvaluateFactory(Q_EntityEvaluation<YardLog>[] Container) {

        Q_EntityEvaluation<YardLog> success = new("Success") {
            Mock = new() {
                Id = 1,
            },
            Expectations = [],
        };
        Q_EntityEvaluation<YardLog> failAllCases = new("All properties fail") {
            Mock = new(),
            Expectations = [
                (nameof(YardLog.Id), [(new PointerValidator(), 3)]),
                (nameof(YardLog.Evidence), [(new LengthValidator(), 1)]),
                (nameof(YardLog.Damage), [(new LengthValidator(), 2)]),
                (nameof(YardLog.FromTo), [(new LengthValidator(), 2)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}