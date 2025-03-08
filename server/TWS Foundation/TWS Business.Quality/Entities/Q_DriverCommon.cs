using CSM_Foundation.Database.Quality;
using CSM_Foundation.Database.Validators;

using TWS_Business.Entities;
using TWS_Business.Entities.Drivers;

namespace TWS_Business.Quality.Entities;
public class Q_DriverCommon : BQ_Entity<Driver_Common> {
    protected override Q_EntityEvaluation<Driver_Common>[] EvaluateFactory(Q_EntityEvaluation<Driver_Common>[] Container) {

        Q_EntityEvaluation<Driver_Common> success = new("Success") {
            Mock = new() {
                Id = 1,
            },
            Expectations = [],
        };
        Q_EntityEvaluation<Driver_Common> failAllCases = new("All properties fail") {
            Mock = new() {
                Id = 0,
                License = "",
                Status = new Status {
                    Id = 1,
                }
            },
            Expectations = [
                (nameof(Driver_Common.Id), [(new PointerValidator(), 3)]),
                (nameof(Driver_Common.License), [(new RequiredValidator(), 1), (new LengthValidator(),2)]),
                (nameof(Driver_Common.Status), [(new PointerValidator(true), 3) ])
            ],
        };


        Container = [.. Container, success, failAllCases];


        return Container;
    }
}