using CSM_Foundation.Databases.Quality.Bases;
using CSM_Foundation.Databases.Quality.Records;
using CSM_Foundation.Databases.Validators;

using TWS_Business.Sets;

namespace TWS_Business.Quality.Sets;
public class Q_TruckCommon : BQ_MigrationSet<TruckCommon> {
    protected override Q_MigrationSet_EvaluateRecord<TruckCommon>[] EvaluateFactory(Q_MigrationSet_EvaluateRecord<TruckCommon>[] Container) {

        Q_MigrationSet_EvaluateRecord<TruckCommon> success = new() {
            Mock = new() {
                Id = 1,
                Vin = "",
                Economic = "",
                Situation = 1,

            },
            Expectations = [],
        };
        Q_MigrationSet_EvaluateRecord<TruckCommon> failAllCases = new() {
            Mock = new() {
                Id = 0,
                Status = 0,
                Situation = 0,
                Vin = "",
                Economic = ""
            },
            Expectations = [
                (nameof(TruckCommon.Id), [(new PointerValidator(), 3)]),
                (nameof(TruckCommon.Vin), [(new LengthValidator(),2)]),
                (nameof(TruckCommon.Economic), [(new LengthValidator(),2)]),
                (nameof(TruckCommon.Status), [(new PointerValidator(), 3)]),

            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}