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
    ResponseController actEffect = await twsPost('view', options, auth: auth);
    return ServiceResolver<SetViewOutput<Account>>(actEffect);
  }
}
