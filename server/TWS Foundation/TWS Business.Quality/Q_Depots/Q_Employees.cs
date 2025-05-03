using TWS_Business.Depots;
using TWS_Business.Entities;
using TWS_Business.Entities.Employees;

namespace TWS_Business.Quality.Q_Depots;

public class Q_Employees : BQ_Business<Employee, EmployeesDepot> {

    protected override Employee EntityFactory(string Entropy) {
        DateOnly date = new(2030, 11, 11);

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

        return new Employee {
            CURP = Entropy + Entropy[..2],
            RFC = Entropy[..13],
            NSS = Entropy[..11],
            Status = status,
            Identification = identification,
            Dates = employee_Dates,
        };
    }
}
