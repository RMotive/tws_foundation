import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/typdefs.dart';
import 'package:tws_foundation_client/src/models/outputs/set_view_output.dart';
import 'package:tws_foundation_client/src/services/security/accounts/account.dart';
import 'package:tws_foundation_client/src/services/security/accounts/accounts_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class AccountsService extends AccountsServiceBase {
  AccountsService(
    Uri host, {
    Client? client,
  }) : super(
          host,
          'Accounts',
          client: client,
        );

  @override
  Effect<SetViewOutput<Account>> view(SetViewOutput<Account> options, String auth) async {
    ResponseController actEffect = await postSecure('view', options, authToken: auth);
    return FoundationResponseResolver<SetViewOutput<Account>>(actEffect);
  }
}
