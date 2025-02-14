using Microsoft.AspNetCore.Mvc;

using TWS_Foundation.Authentication;

namespace TWS_Foundation.Controllers.Human_Resources;

[ApiController, Feature("Employee"), Route("[Controller]/[Action]")]
public class EmployeesController
    : ControllerBase {

}
