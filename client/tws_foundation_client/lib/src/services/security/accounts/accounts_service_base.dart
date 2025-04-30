import 'package:tws_foundation_client/src/services/foundation_service_b.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

abstract class AccountsServiceBase extends FoundationServiceB {
  AccountsServiceBase(
    super.host,
    super.servicePath, {
    super.client,
  });

  /// Transaction to generate a set view object.
  Effect<SetViewOutput<Account>> view(SetViewOutput<Account> options, String auth);
}
