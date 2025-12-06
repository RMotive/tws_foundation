using TWS_Business.Depots.Vehicles.Control;
using TWS_Business.Entities;
using TWS_Business.Entities.Drivers;
using TWS_Business.Entities.Employees;
using TWS_Business.Entities.Vehicules.Trucks;
using TWS_Business.Quality.Utils;

namespace TWS_Business.Quality.Q_Depots;

public class Q_YardLogs : BQ_Business<YardLog, YardLogsDepot> {

    protected override YardLog EntityFactory(string entropy) {


        return new() {
            Entry = true,
            Reservation = false,
            FromTo = entropy,
            LoadType = Store(BusinessDraftUtils.SampleLoadtype()),
            Guard = Store(new Employee() {
                CURP = entropy,
                RFC = entropy[..13],
                NSS = entropy[..11],
                Identification = Store(new Identification() {
                    Name = entropy,
                    FirstLastname = entropy,
                    SecondLastname = entropy,
                    Status = Store(BusinessDraftUtils.SampleStatus("gis")),
                }),
                Status = Store(BusinessDraftUtils.SampleStatus("gi1")),
                Dates = Store(new Employee_Dates()),
            }),
            Section = Store(new Section() {
                Name = entropy,
                Status = Store(BusinessDraftUtils.SampleStatus("yss")),
                Yard = Store(new Location() {
                    Name = entropy,
                    Status = Store(BusinessDraftUtils.SampleStatus("ysy")),
                    Address = Store(BusinessDraftUtils.SampleAddress()),
                })
            }),
            Driver = Store(
                new Driver_Common() {
                    License = entropy[..12],
                    Status = Store(BusinessDraftUtils.SampleStatus("yds")),
                    Situation = Store(BusinessDraftUtils.SampleSituation()),
                    External = Store(new DriverExternal() {
                        Identification = Store(new Identification() {
                            Name = "driver_" + entropy,
                            FirstLastname = "driver" + entropy,
                            SecondLastname = "Second lastname" + entropy,
                            Status = Store(BusinessDraftUtils.SampleStatus("dei"))
                        })
                    })
                }),
            Truck = Store(
                new Truck_Common() {
                    Economic = entropy[..16],
                    Status = Store(BusinessDraftUtils.SampleStatus("ytt")),
                    External = Store(new TruckExternal() {
                        Carrier = entropy,
                    })
                })

        };
    }
}
