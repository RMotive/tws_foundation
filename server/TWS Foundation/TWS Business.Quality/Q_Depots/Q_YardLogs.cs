using TWS_Business.Depots.Vehicles.Control;
using TWS_Business.Entities;
using TWS_Business.Entities.Drivers;
using TWS_Business.Entities.Employees;
using TWS_Business.Entities.Vehicules;

namespace TWS_Business.Quality.Q_Depots;

public class Q_YardLogs : BQ_Business<YardLog, YardLogsDepot> {

    protected override YardLog EntityFactory(string Entropy) {
        DateOnly date = new(2030, 11, 11);

        LoadType loadtype = Store(
                new LoadType {
                    Name = Entropy,
                    Description = Entropy,
                }
            );

        Status status = Store(
                new Status {
                    Name = Entropy,
                    Description = Entropy,
                }
            );

        Identification identification = Store(
                 new Identification {
                     Name = Entropy,
                     Lastname = Entropy,
                     Status = status,
                 }
        );

        Employee_Dates employee_Dates = Store(
        new Employee_Dates {
            CNAP = date,
            IMSS = date,
            Hire = date,
            Termination = date,
        }
            );

        Employee employee = Store(
                new Employee {
                    CURP = Entropy + Entropy[..2],
                    RFC = Entropy[..13],
                    NSS = Entropy[..11],
                    Status = status,
                    Identification = identification,
                    Dates = employee_Dates,
                }
            );

        Section section = Store(
                new Section {
                    Name = Entropy,
                    Capacity = 10,
                    Ocupancy = 1,
                    Status = new Status {
                        Name = Entropy,
                        Description = Entropy,
                    },
                    Yard = new Location {
                        Name = Entropy,
                        Description = Entropy,
                        Status = new Status {
                            Name = "Y" + Entropy,
                        },
                        Address = new Address {
                            State = Entropy[..3],
                            Street = Entropy,
                            AltStreet = Entropy,
                            City = Entropy,
                            ZIP = Entropy[..5],
                            Country = Entropy[..3],
                            Subdivision = Entropy,
                        }
                    }
                }
            );

        Situation situation = Store(
               new Situation {
                   Name = Entropy,
                   Description = Entropy,
               }
           );

        Driver driver = Store(
                new Driver {
                    Fast = Entropy[..12],
                    ANAM = Entropy + Entropy[..8],
                    VISA = Entropy[..12],
                    TWIC = Entropy[..12],
                    DriverType = Entropy[..12],
                    LicenseExpiration = date,
                    DrugalcRegistrationDate = date,
                    PullnoticeRegistrationDate = date,
                    TwicExpiration = date,
                    VisaExpiration = date,
                    FastExpiration = date,
                    AnamExpiration = date,
                    Employee = employee,
                }
            );

        Driver_Common driverCommon = Store(
                new Driver_Common {
                    License = Entropy[..12],
                    Situation = situation,
                    Status = status,
                    Internal = driver,
                }
            );
        return new YardLog {
            Entry = true,
            Seal = Entropy,
            FromTo = Entropy,
            Evidence = [],
            LoadType = loadtype,
            Guard = employee,
            Section = section,
            Driver = driverCommon,
        };
    }
}
