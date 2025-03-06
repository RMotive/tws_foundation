using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality;

using TWS_Business.Entities.Employees;

namespace TWS_Business.Quality.Entities.Employees;
/// <summary>
///     Qualifies the <see cref="EmployeesDepot"/>.
/// </summary>
public class Q_EmployeesDepot
    : BQ_Depot<Employee, EmployeesDepot, Database> {
    public Q_EmployeesDepot()
        : base(nameof(Employee.Id)) {
    }

    protected override Employee MockFactory(string RandomSeed) {

        return new() {
            CURP = RandomUtils.String(18),
            RFC = RandomUtils.String(12),
            NSS = RandomUtils.String(11)
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Employee Mock) {
        return (nameof(Employee.CURP), Mock.CURP);
    }
}