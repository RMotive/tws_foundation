using System.Collections.Immutable;

using TWS_Business.Depots;
using TWS_Business.Entities;
using TWS_Business.Entities.Drivers;
using TWS_Business.Entities.Employees;
using TWS_Business.Quality.Q_Depots.Bases;

namespace TWS_Business.Quality.Q_Depots;

public class Q_Drivers_Commons : BQ_Common<Driver_Common, Driver, DriverExternal, Drivers_CommonsDepot> {

    protected override Driver_Common EntityFactory(string Entropy, bool internalEdge) {

        Situation situation = Store(
                new Situation {
                    Name = Entropy,
                    Description = Entropy,
                    Reference = Entropy[..8],
                }
            );

        Status status = Store(
                new Status {
                    Name = Entropy,
                    Description = Entropy,
                    Reference = Entropy[..8],
                }
            );

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
                    Lastname = Entropy,
                    Status = statusI,
                }
             );

        Driver_Common common = new Driver_Common {
            License = Entropy[..12],
            Situation = situation,
            Status = status,
        };

        if (internalEdge) {
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

            common.Internal = new Driver {
                Employee = employee,
            };

        } else {
            common.External = new DriverExternal {
                Identification = identification,
            };
        }
        return common;
    }
}
