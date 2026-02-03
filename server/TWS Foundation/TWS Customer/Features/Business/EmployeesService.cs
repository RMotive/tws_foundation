using CSM_Database_Core.Depots.Models;

using CSM_Foundation.Product;

using TWS_Business.Depots;
using TWS_Business.Entities;
using TWS_Business.Entities.Employees;

using TWS_Customer.Managers.Auth;
using TWS_Customer.Managers.Session;

using Database = TWS_Business.Database;

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
    ///     User employee data.
    /// </returns>
    public Task<Employee?> Get();
}

/// <summary>
///     [Service] for <see cref="Location"/> based operations.
/// </summary>
public class EmployeesService
    : BService<Employee, EmployeesDepot>, IEmployeesService {


    readonly IAuthManager _authManager;

    private readonly Database _db;

    /// <summary>
    ///     Creates a new instance of <see cref="EmployeesService"/>.
    /// </summary>
    /// <param name="depot">
    ///     <see cref="Employee"/> based [Depot] handler to be used.
    /// </param>
    public EmployeesService(
        EmployeesDepot depot,
        IAuthManager authManager,
        Database database
    ) : base(depot) {
        _authManager = authManager;
        _db = database;
    }

    public async Task<Employee?> Get() {

        SessionData sessionData = await _authManager.Get();

        long accountId = sessionData.Account.Id;

        BatchOperationOutput<Employee> employeesReadOutput = await depot.Read(
                new QueryInput<Employee, FilterQueryInput<Employee>> {
                    Parameters = new FilterQueryInput<Employee> {
                        Behavior = FilteringBehaviors.First,
                        Filter = (employee) => employee.AccountShadow == accountId
                    }
                }
            );

        if (employeesReadOutput.SuccessesCount <= 0)
            return null;


        return employeesReadOutput.Successes[0];
    }
}
