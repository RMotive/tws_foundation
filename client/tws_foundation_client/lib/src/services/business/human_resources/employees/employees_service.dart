import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {abstract} class.
///
/// Implements base shared [EmployeesServiceI] behavior for all [Employee] based [IService].
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
/// Defines a [IService] contract for [Employee] operations.
abstract interface class EmployeesServiceI extends FoundationServiceB implements IService, IViewService<Employee, FoundationResponseResolver<ViewOutput<Employee>>>, ICreateService<Employee, FoundationResponseResolver<BatchOperationOutput<Employee>>> {
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

  /// Updates a [Employee] based on the [Employee.Id] pointer.
  ///
  ///
  /// [input] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<UpdateOutput<Employee>> update(UpdateInput<Employee> input, String auth);
}

/// {service} class.
///
/// Implements a [IService] for [Employee] based operations, providing final behavior operations.
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

  @override
  FoundationFutureResolver<UpdateOutput<Employee>> update(UpdateInput<Employee> input, String authToken) async {
    return FoundationResponseResolver<UpdateOutput<Employee>>(
      await postSecure(
        'update',
        input,
        authToken: authToken,
      ),
    );
  }
}
