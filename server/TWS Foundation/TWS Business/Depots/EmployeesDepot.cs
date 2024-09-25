using CSM_Foundation.Database.Bases;

using TWS_Business.Sets;

namespace TWS_Business.Depots;
/// <summary>
///     Implements a <see cref="BDepot{TMigrationDatabases, TMigrationSet}"/>
///     representing a depot to handle <see cref="Employee"/> dataDatabases entity mirror.
/// </summary>
public class EmployeesDepot : BDepot<TWSBusinessDatabase, Employee> {
    /// <summary>
    ///     Generates a new depot handler for <see cref="Employee"/>.
    /// </summary>
    public EmployeesDepot() : base(new(), null) {
    }
}
