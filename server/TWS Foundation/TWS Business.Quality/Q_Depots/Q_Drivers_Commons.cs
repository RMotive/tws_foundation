using TWS_Business.Depots;
using TWS_Business.Entities;
using TWS_Business.Entities.Drivers;
using TWS_Business.Entities.Employees;

namespace TWS_Business.Quality.Q_Depots;

public class Q_Drivers_Commons : BQ_Business<Driver_Common, Drivers_CommonsDepot> {

    protected override Driver_Common EntityFactory(string Entropy) {
        DateOnly date = new DateOnly(2030, 11, 11);
        Situation situation = Store(
                new Situation {
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

        Identification extIdentification = Store(
                new Identification {
                    Name = "External" + Entropy,
                    Lastname = "External" + Entropy,
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

        DriverExternal driverExternal = Store(
                new DriverExternal {
                    Identification = extIdentification,
                }
            );


        return new Driver_Common {
            License = Entropy[..12],
            Situation = situation,
            Status = status,
            Internal = driver,
            External = driverExternal,
        };
    }
}
