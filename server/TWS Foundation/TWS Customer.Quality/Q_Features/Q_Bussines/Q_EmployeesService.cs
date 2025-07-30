using TWS_Business.Entities.Employees;

using TWS_Customer.Features.Business;


namespace TWS_Customer.Quality.Q_Features.Q_Bussines;

public class Q_EmployeesService
    : BQ_Service<IEmployeesService, Employee> {

    protected override Employee DraftEntity(string entropy) {
        throw new NotImplementedException();
    }

    protected override IEmployeesService ServiceFactory() {
        throw new NotImplementedException();
    }
}
