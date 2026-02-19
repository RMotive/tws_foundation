import 'package:csm_client_core/csm_client_core.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

/// {interface} class.
///
/// Defines a [IService] contract for [Account] operations.
abstract interface class AccountServiceI extends FoundationServiceB implements IService, ViewServiceI<Account>, CreateServiceI<Account> {
  /// Creates a new [AccountServiceI] instance.
  AccountServiceI(
    super.host,
    super.servicePath,
  );

  
  /// Updates a [Account] based on the [Account.Id] pointer.
  ///
  ///
  /// [input] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<UpdateOutput<Account>> update(UpdateInput<Account> input, String auth);

  /// Updates a [Account] based on the [Account.Id] pointer.
  ///
  ///
  /// [entity] record properties to update at the data storage.
  ///
  /// [auth] server authorization token.
  FoundationFutureResolver<Account> delete(Account entity, String auth);
}

/// {abstract} class.
///
/// Implements base shared [EmployeesServiceI] behavior for all [Account] based [IService].
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
/// Implements a [IService] for [Account] based operations, providing final behavior operations.
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

  @override
  FoundationFutureResolver<BatchOperationOutput<Account>> create(List<Account> accounts, String authToken) async {
    return FoundationResponseResolver<BatchOperationOutput<Account>>(
      await postListSecure<Account>(
        'create',
        accounts,
        authToken: authToken,
      ),
    );
  }

  @override
  FoundationFutureResolver<UpdateOutput<Account>> update(UpdateInput<Account> input, String authToken) async {
    return FoundationResponseResolver<UpdateOutput<Account>>(
      await postSecure(
        'update',
        input,
        authToken: authToken,
      ),
    );
  }

  @override
  FoundationFutureResolver<Account> delete(Account entity, String authToken) async {
    return FoundationResponseResolver<Account>(
      await postSecure(
        'delete',
        entity,
        authToken: authToken,
      ),
    );
  }

}