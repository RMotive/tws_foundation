using CSM_Foundation.Customer;
using CSM_Foundation.Database.Entity;

using TWS_Business.Depots;
using TWS_Business.Entities.Employees;

namespace TWS_Customer.Services.Business.Employees;

public abstract class BEmployeesService
    : BService<Employee, IEmployeesDepot>, IEmployeesService {
    public BEmployeesService(IEmployeesDepot Depot, AccumulateDelegate<Employee>? Accumulate = null)
        : base(Depot, Accumulate) {
    }
}

/// <summary>
/// 
/// </summary>
public class EmployeesService
    : BEmployeesService {

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Employees"></param>
    public EmployeesService(IEmployeesDepot Employees)
        : base(Employees, null) {
    }
}
