import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class EmployeeService extends EmployeeServiceBase {
  EmployeeService(
    CSMUri host, {
    Client? client,
  }) : super(
          host,
          'Employees',
          client: client,
        );
        
  @override
  Effect<SetViewOut<Employee>> view(SetViewOptions<Employee> options, String auth) async {
    CSMActEffect actEffect = await twsPost('view', options, auth: auth);
    return MainResolver<SetViewOut<Employee>>(actEffect);
  }
}
      