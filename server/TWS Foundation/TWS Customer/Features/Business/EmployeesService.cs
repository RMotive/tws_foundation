using CSM_Foundation.Customer;
using CSM_Foundation.Database.Entity.Depot.IDepot_Read;
using CSM_Foundation.Database.Entity.Models.Input;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business.Depots;
using TWS_Business.Entities;
using TWS_Business.Entities.Employees;

using TWS_Customer.Managers.Auth;
using TWS_Customer.Managers.Session;

namespace TWS_Customer.Features.Business;

/// <summary>
///     [Interface] for <see cref="Employee"/> based [Service] implementations.
/// </summary>
public interface IEmployeesService
    : IService<Employee> {

    
    /// <summary>
    ///     Gets the <see cref="Employee"/> data for the current session account.
    /// </summary>
    /// <returns>
    ///     Found <see cref="Employee"/> data.
    /// </returns>
    public Task<Employee> Get();
}

/// <summary>
///     [Service] for <see cref="Location"/> based operations.
/// </summary>
public class EmployeesService
    : BService<Employee, IEmployeesDepot>, IEmployeesService {


    readonly IAuthManager _authManager;

    /// <summary>
    ///     Creates a new instance of <see cref="EmployeesService"/>.
    /// </summary>
    /// <param name="depot">
    ///     <see cref="Employee"/> based [Depot] handler to be used.
    /// </param>
    public EmployeesService(
        IEmployeesDepot depot,
        IAuthManager authManager
    )  : base(depot) { 
        
        _authManager = authManager;
    }

    public async Task<Employee> Get() {

        SessionData sessionData = await _authManager.Get();

        long accountId = sessionData.Account.Id;

        BatchOperationOutput<Employee> employeesReadOutput = await _depot.Read(
                new QueryInput<Employee, FilterQueryInput<Employee>> {
                    Parameters = new FilterQueryInput<Employee> {
                        Behavior = FilteringBehaviors.First,
                        Filter = (employee) => employee.AccountShadow == accountId
                    }
                }
            );

        if(employeesReadOutput.Failed) {
            throw new Exception();
        }


        return employeesReadOutput.Successes[0];
    }
}
