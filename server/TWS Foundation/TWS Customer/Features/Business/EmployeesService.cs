using CSM_Foundation.Customer;
using CSM_Foundation.Database.Entity.Models;
using CSM_Foundation.Database.Entity.Models.Output;

using TWS_Business;
using TWS_Business.Depots;
using TWS_Business.Entities;
using TWS_Business.Entities.Drivers;
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
    : BService<Employee, EmployeesDepot>, IEmployeesService {

    private readonly Database _db;

    /// <summary>
    ///     Creates a new instance of <see cref="EmployeesService"/>.
    /// </summary>
    /// <param name="Depot">
    ///     <see cref="Employee"/> based [Depot] handler to be used.
    /// </param>
    public EmployeesService(EmployeesDepot Depot, Database database) : base(Depot) { 
        this._db = database;
    }

    public async override Task<BatchOperationOutput<Employee>> Create(Employee[] Entities, bool Sync = false) {
        Employee[] successes = [];
        EntityOperationFailure<Employee>[] failures = [];

        foreach (Employee entity in Entities) {
            try {
                Employee attachedEntity = await _depot.Store(entity);
                successes = [.. successes, attachedEntity];
            } catch (Exception excep) {
                if (Sync) {
                    throw;
                }

                EntityOperationFailure<Employee> fail = new(entity, excep);
                failures = [.. failures, fail];
            }
        }

        _db.SaveChanges();

        BatchOperationOutput<Employee> output = new(successes, failures);

        return output;
    }
}
