import 'package:csm_client/csm_client.dart';
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
  Effect<SetViewOut<Account>> view(SetViewOptions<Account> options, String auth) async {
    CSMActEffect actEffect = await twsPost('view', options, auth: auth);
    return MainResolver<SetViewOut<Account>>(actEffect);
  }
}
