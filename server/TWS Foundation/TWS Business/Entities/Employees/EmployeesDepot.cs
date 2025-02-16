using CSM_Foundation.Database.Entity;

namespace TWS_Business.Entities.Employees;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Employee"/> dataDatabases entity mirror.
/// </summary>
public class EmployeesDepot
    : BDepot<BusinessDatabase, Employee>, IEmployeesDepot {

    /// <summary>
    ///     Generates a new depot handler for <see cref="Employee"/>.
    /// </summary>
    public EmployeesDepot(BusinessDatabase Databases, IDisposer? Disposer = null)
        : base(Databases, Disposer) {
    }
    public EmployeesDepot()
        : base(new(), null) {
    }
}
