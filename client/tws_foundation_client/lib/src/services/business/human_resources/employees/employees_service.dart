import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {abstract} class.
///
/// Implements base shared [EmployeesServiceI] behavior for all [Employee] based [ServiceI].
abstract class EmployeesServiceB extends FoundationServiceB implements EmployeesServiceI {
  /// Creates a new [EmployeesServiceB] instance.
  ///
  ///
  /// [host] server host address.
  ///
  /// [servicePath] service path address.
  ///
  /// [client] custom network [Client] to testing/quality purposes.
  EmployeesServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}

/// {interface} class.
///
/// Defines a [ServiceI] contract for [Employee] operations.
abstract interface class EmployeesServiceI extends FoundationServiceB implements ServiceI, ViewServiceI<Employee>, CreateServiceI<Employee> {
  /// Creates a new [EmployeesServiceI] instance.
  EmployeesServiceI(
    super.host,
    super.servicePath,
  );

  /// Gets the current application user [Employee] data if there's.
  ///
  ///
  /// [authToken] authentication session token.
  FoundationFutureResolver<Employee?> getUserEmployee(String authToken);
}

/// {service} class.
///
/// Implements a [ServiceI] for [Employee] based operations, providing final behavior operations.
final class EmployeesService extends EmployeesServiceB {
  /// Creates a new [EmployeesService] instance.
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

  @override
  FoundationFutureResolver<BatchOperationOutput<Employee>> create(List<Employee> employees, String authToken) async {
    return FoundationResponseResolver<BatchOperationOutput<Employee>>(
      await postListSecure<Employee>(
        'create',
        employees,
        authToken: authToken,
      ),
    );
  }

  @override
  FoundationFutureResolver<Employee?> getUserEmployee(String authToken) async {
    return FoundationResponseResolver<Employee?>(
      await getSecure(
        'get',
        authToken,
      ),
    );
  }
}
