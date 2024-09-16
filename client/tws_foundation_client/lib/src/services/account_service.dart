import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/src/services/bases/accounts_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class AccountService extends AccountsServiceBase {
  AccountService(
    CSMUri host, {
    Client? client,
  }) : super(
          host,
          'Accounts',
          client: client,
        );
        
  @override
  Effect<SetViewOut<Account>> view(SetViewOptions options, String auth) async {
    CSMActEffect actEffect = await post('view', options, auth: auth);
    return MainResolver<SetViewOut<Account>>(actEffect);
  }
}
      