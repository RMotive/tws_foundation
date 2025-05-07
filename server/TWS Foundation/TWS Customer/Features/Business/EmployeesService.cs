using CSM_Foundation.Customer;

using TWS_Business.Depots;
using TWS_Business.Entities;
using TWS_Business.Entities.Employees;

namespace TWS_Customer.Features.Business;

/// <summary>
///     [Interface] for <see cref="Employee"/> based [Service] implementations.
/// </summary>
public interface IEmployeesService
    : IService<Employee> {
}

/// <summary>
///     [Service] for <see cref="Location"/> based operations.
/// </summary>
public class EmployeesService
    : BService<Employee, IEmployeesDepot>, IEmployeesService {

    /// <summary>
    ///     Creates a new instance of <see cref="EmployeesService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Employee"/> based [Depot] handler to be used.
    /// </param>
    public EmployeesService(IEmployeesDepot Depot) : base(Depot) { }
}
