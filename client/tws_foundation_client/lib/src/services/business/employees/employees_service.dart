import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/business/employees/employees_service_b.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

///
final class EmployeesService extends EmployeesServiceB {
  ///
  EmployeesService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'employees',
        );

  @override
  FoundationFutureResolver<ViewOutput<Employee>> view(ViewInput<Employee> input, String authToken) async {
    return FoundationResponseResolver<ViewOutput<Employee>>(
      await postSecure<ViewInput<Employee>>(
        'view',
        input,
        authToken: authToken,
      ),
    );
  }
}
