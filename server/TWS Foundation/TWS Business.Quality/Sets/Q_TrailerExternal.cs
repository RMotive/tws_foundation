using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

using TWS_Business.Sets;

namespace TWS_Business.Quality.Sets;
public class Q_TrailerExternal : BQ_Set<TrailerExternal> {
    protected override Q_MigrationSet_EvaluateRecord<TrailerExternal>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<TrailerExternal>[] Container) {

        Q_MigrationSet_EvaluateRecord<TrailerExternal> success = new() {
            Mock = new() {
                Id = 1,
                Status = 1,
                Common = 1
            },
            Expectations = [],
        };
        Q_MigrationSet_EvaluateRecord<TrailerExternal> failAllCases = new() {
            Mock = new() {
                Id = 0,
                Status = 0,
                Common = 0,
                Carrier = "",
                MxPlate = ""
            },
            Expectations = [
                (nameof(TrailerExternal.Id), [(new PointerValidator(), 3)]),
                (nameof(TrailerExternal.Status), [(new PointerValidator(), 3)]),
                (nameof(TrailerExternal.Common), [(new PointerValidator(), 3)]),
                (nameof(TrailerExternal.MxPlate), [(new LengthValidator(), 2)]),
                (nameof(TrailerExternal.Carrier), [(new LengthValidator(), 2)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}