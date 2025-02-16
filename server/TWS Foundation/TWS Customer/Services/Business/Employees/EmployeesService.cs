

using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Entities.Employees;

namespace TWS_Customer.Services.Business.Employees;

/// <summary>
/// 
/// </summary>
public class EmployeesService
    : IEmployeesService {
    /// <summary>
    /// 
    /// </summary>
    readonly IEmployeesDepot Employees;

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Employees"></param>
    public EmployeesService(IEmployeesDepot Employees) {
        this.Employees = Employees;
    }

    public Task<SetViewOut<Employee>> View(SetViewOptions<Employee> Options) {
        throw new NotImplementedException();
    }

    public Task<SetBatchOut<Employee>> Create(Employee[] Solutions) {
        throw new NotImplementedException();
    }

    public Task<RecordUpdateOut<Employee>> Update(Employee Solution) {
        throw new NotImplementedException();
    }

    public Task<Employee> Delete(int Id) {
        throw new NotImplementedException();
    }
}
