using CSM_Foundation.Database.Models.Options;
using CSM_Foundation.Database.Models.Out;

using TWS_Business.Sets;

namespace TWS_Customer.Services.Interfaces;
public interface IEmployeesService {
    Task<SetViewOut<Employee>> View(SetViewOptions<Employee> Options);
}
