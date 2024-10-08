import 'package:test/test.dart';
import 'package:tws_foundation_client/src/services/bases/accounts_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../integration_credentials.dart';
void main() {
  late String auth;
  late AccountsServiceBase service;
  setUp(
    () async {
      final TWSFoundationSource source = TWSFoundationSource(false);
      MainResolver<Privileges> resolver = await source.security.authenticate(testCredentials);
      resolver.resolve(
        decoder: PrivilegesDecode(),
        onConnectionFailure: () {
          throw 'ConnectionFailure';
        },
        onFailure: (FailureFrame failure, int status) {
          throw failure;
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
        onSuccess: (SuccessFrame<Privileges> success) {
          auth = success.estela.token;
        },
      );

      service = source.accounts;
    },
  );

  test(
    'View',
    () async {
      MainResolver<SetViewOut<Account>> fact = await service.view(
        SetViewOptions<Account>(false, 10, 1, null, <SetViewOrderOptions>[], <SetViewFilterNodeInterface<Account>>[]),
        auth,
      );
      fact.resolve(
        decoder: SetViewOutDecode<Account>(AccountDecoder()),
        onConnectionFailure: () {
          throw 'ConnectionFailure';
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
        onFailure: (FailureFrame failure, int status) {
          throw failure.estela.system;
        },
        onSuccess: (SuccessFrame<SetViewOut<Account>> success) {
          SetViewOut<Account> fact = success.estela;

          expect(fact.amount >= fact.records, true);
          expect(fact.records >= 0, true);
          expect(fact.page, 1);
          expect(fact.pages >= fact.page, true);
          expect(fact.sets.length, fact.records);
        },
      );
    },
  );
}
