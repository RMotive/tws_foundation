import 'package:tws_foundation_client/src/services/tws_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

abstract class AccountsServiceBase extends TWSServiceBase {
  AccountsServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  /// Transaction to generate a set view object.
  Effect<SetViewOut<Account>> view(SetViewOptions<Account> options, String auth);

  /// Transaction to create a set view object.
  Effect<SetBatchOut<Account>> create(List<Account> accounts, String auth);

  /// Transaction to update a set object.
  Effect<RecordUpdateOut<Account>> update(Account account, String auth);
}
