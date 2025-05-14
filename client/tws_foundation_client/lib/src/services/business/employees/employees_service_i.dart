import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} for [EmployeesServiceI].
///
/// Defines base contract for [EmployeesServiceI] implementations that specifies the methods to have providing [Employee] based operations and management.
abstract interface class EmployeesServiceI extends FoundationServiceB implements ServiceI {
  /// Creates a new [EmployeesServiceI] instance.
  EmployeesServiceI(super.host, super.servicePath);

 /// Generates a complex [View] for [Employee] set.
  ///
  ///
  /// [options] how the method will build the [View] result, are instructions for the paging, ordering, etc.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<ViewOutput<Employee>> view(ViewInput<Employee> input, String auth);

}
