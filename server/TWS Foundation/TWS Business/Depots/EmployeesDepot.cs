using CSM_Foundation.Database.Entity;

using TWS_Business.Entities.Employees;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Employee"/> dataDatabases entity mirror.
/// </summary>
public class EmployeesDepot
    : BDepot<Database, Employee>, IEmployeesDepot {

    /// <summary>
    ///     Generates a new depot handler for <see cref="Employee"/>.
    /// </summary>
    public EmployeesDepot(Database Databases, IDisposer? Disposer = null)
        : base(Databases, Disposer) {
    }
    public EmployeesDepot()
        : base(new(), null) {
    }
}
