using CSM_Foundation.Database.Entity;
using CSM_Foundation.Database.Entity.Depot;

using TWS_Business.Entities.Employees;

namespace TWS_Business.Depots;

/// <summary>
///     [Interface] for <see cref="Employee"/> based depot implementations.
/// </summary>
public interface IEmployeesDepot
    : IDepot<Employee> {

}

/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Employee"/> dataDatabases entity mirror.
/// </summary>
public class EmployeesDepot
    : BDepot<Database, Employee>, IEmployeesDepot {

    /// <summary>
    ///     Generates a new depot handler for <see cref="Employee"/>.
    /// </summary>
    public EmployeesDepot(Database Databases, IDisposer? Disposer = null) : base(Databases, Disposer) { }
}
