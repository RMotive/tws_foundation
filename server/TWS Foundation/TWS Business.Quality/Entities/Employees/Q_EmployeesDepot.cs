using CSM_Foundation.Core.Utils;
using CSM_Foundation.Database.Quality;

using TWS_Business.Entities.Employees;

namespace TWS_Business.Quality.Entities.Employees;
/// <summary>
///     Qualifies the <see cref="EmployeesDepot"/>.
/// </summary>
public class Q_EmployeesDepot
    : BQ_Depot<Employee, EmployeesDepot, BusinessDatabase> {
    public Q_EmployeesDepot()
        : base(nameof(Employee.Id)) {
    }

    protected override Employee MockFactory(string RandomSeed) {

        return new() {
            Identification = 1,
            Status = 1,
            Approach = 1,
            Address = 1,
            Curp = RandomUtils.String(18),
            Rfc = RandomUtils.String(12),
            Nss = RandomUtils.String(11)
        };
    }

    protected override (string Property, string? Value)? FactorizeProperty(Employee Mock)
    => (nameof(Employee.Curp), Mock.Curp);
}