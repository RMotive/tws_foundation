using TWS_Business.Depots;
using TWS_Business.Entities;
using TWS_Business.Entities.Drivers;
using TWS_Business.Entities.Employees;
using TWS_Business.Quality.Q_Depots.Bases;

namespace TWS_Business.Quality.Q_Depots;

public class Q_Drivers :
    BQ_CommonDepot<Driver_Common, Driver, DriverExternal, DriversDepot> {

    protected override Driver_Common EntityFactory(string entropy) {
        Situation situation = Store(
                new Situation {
                    Name = entropy,
                    Description = entropy,
                    Reference = entropy[..8],
                }
            );

        Status status = Store(
                new Status {
                    Name = entropy,
                    Description = entropy,
                    Reference = entropy[..8],
                }
            );

        Driver_Common common = new Driver_Common {
            License = entropy[..12],
            Situation = situation,
            Status = status,
        };

        return common;
    }

    protected override DriverExternal ExternalFactory(string Entropy) {

        Status statusI = Store(
                new Status {
                    Name = 'I' + Entropy,
                    Description = Entropy,
                    Reference = "I" + Entropy[..7],
                }
            );

        Identification identification = Store(
                new Identification {
                    Name = Entropy,
                    LastName = Entropy,
                    Status = statusI,
                }
             );

        return new DriverExternal {
            Identification = identification,
        };
    }

    protected override Driver InternalFactory(string Entropy) {

        Status statusI = Store(
                new Status {
                    Name = 'I' + Entropy,
                    Description = Entropy,
                    Reference = "I" + Entropy[..7],
                }
            );

        Identification identification = Store(
                new Identification {
                    Name = Entropy,
                    LastName = Entropy,
                    Status = statusI,
                }
             );

        Employee_Dates dates = Store(new Employee_Dates());

        Status statusEmp = Store(
               new Status {
                   Name = 'D' + Entropy,
                   Description = Entropy,
                   Reference = "D" + Entropy[..7],
               }

           );

        Employee employee = Store(
                new Employee {
                    Identification = identification,
                    Dates = dates,
                    Status = statusEmp

                }
            );

        return new Driver {
            Employee = employee,
        };
    }
}
