import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class AccountsService extends AccountsServiceBase {
  AccountsService(
    CSMUri host, {
    Client? client,
  }) : super(
          host,
          'Accounts',
          client: client,
        );

  @override
  Effect<SetViewOutput<Account>> view(SetViewOutput<Account> options, String auth) async {
    CSMActEffect actEffect = await twsPost('view', options, auth: auth);
    return ServiceResolver<SetViewOutput<Account>>(actEffect);
  }
}
