import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} class.
///
/// Defines a [ServiceI] contract for [Account] operations.
abstract interface class AccountServiceI extends FoundationServiceB implements ServiceI, ViewServiceI<Account> {
  /// Creates a new [AccountServiceI] instance.
  AccountServiceI(
    super.host,
    super.servicePath,
  );
}

/// {abstract} class.
///
/// Implements base shared [EmployeesServiceI] behavior for all [Account] based [ServiceI].
abstract class AccountServiceB extends FoundationServiceB implements AccountServiceI {
  /// Creates a new [AccountServiceB] instance.
  ///
  ///wd
  /// [host] server host address.
  ///
  /// [servicePath] service path address.
  ///
  /// [client] custom network [Client] to testing/quality purposes.
  AccountServiceB(
    super.host,
    super.servicePath, {
    super.client,
    super.headers,
  });
}

/// {service} class.
///
/// Implements a [ServiceI] for [Account] based operations, providing final behavior operations.
final class AccountService extends AccountServiceB {
  /// Creates a new [AccountService] instance.
  AccountService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'accounts',
        );

  @override
  FoundationFutureResolver<ViewOutput<Account>> view(ViewInput<Account> input, String authToken) async {
    return FoundationResponseResolver<ViewOutput<Account>>(
      await postSecure<ViewInput<Account>>(
        'view',
        input,
        authToken: authToken,
      ),
    );
  }
}