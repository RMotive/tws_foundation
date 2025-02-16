using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;

namespace TWS_Business.Quality.Entities;
public class Q_YardLog : BQ_Entity<YardLog> {
    protected override Q_EntityEvaluation<YardLog>[] EvaluateFactory(Q_EntityEvaluation<YardLog>[] Container) {

        Q_EntityEvaluation<YardLog> success = new("Success") {
            Mock = new() {
                Id = 1,
                LoadType = 0,
            },
            Expectations = [],
        };
        Q_EntityEvaluation<YardLog> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
                LoadType = 0,
                TTPicture = "",
                Gname = "",
                FromTo = ""
            },
            Expectations = [
                (nameof(YardLog.Id), [(new PointerValidator(), 3)]),
                (nameof(YardLog.TTPicture), [(new RequiredValidator(), 1)]),
                (nameof(YardLog.Gname), [(new LengthValidator(), 2)]),
                (nameof(YardLog.FromTo), [(new LengthValidator(), 2)]),
                (nameof(YardLog.LoadType), [(new PointerValidator(true), 3)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}