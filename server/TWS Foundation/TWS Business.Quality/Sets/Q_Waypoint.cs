using CSM_Foundation.Database.Quality.Bases;
using CSM_Foundation.Database.Quality.Records;
using CSM_Foundation.Database.Validators;

using Newtonsoft.Json;

using TWS_Business.Sets;

namespace TWS_Business.Quality.Sets;
public class Q_Waypoint : BQ_Set<Waypoint> {
    protected override Q_MigrationSet_EvaluateRecord<Waypoint>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<Waypoint>[] Container) {

        Q_MigrationSet_EvaluateRecord<Waypoint> success = new("Success") {
            Mock = new() {
                Id = 1,
            },
            Expectations = [],
        };
        Q_MigrationSet_EvaluateRecord<Waypoint> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
            },
            Expectations = [
                (nameof(Waypoint.Id), [(new PointerValidator(), 3)]),
                (nameof(Waypoint.Latitude), [(new RequiredValidator(), 1)]),
                (nameof(Waypoint.Longitude), [(new RequiredValidator(), 1)]),
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}