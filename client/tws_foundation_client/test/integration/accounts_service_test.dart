import 'package:test/test.dart';
import 'package:tws_foundation_client/src/services/bases/accounts_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../secrets/credentials.dart';

void main() {
  late String auth;
  late AccountsServiceBase service;
  setUp(
    () async {
      final TWSFoundationSource source = TWSFoundationSource(false);
      MainResolver<Privileges> resolver = await source.security.authenticate(qualityCredentials);
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
      MainResolver<MigrationView<Account>> fact = await service.view(
        MigrationViewOptions(null, <MigrationViewOrderOptions>[], 1, 10, false),
        auth,
      );
      fact.resolve(
        decoder: MigrationViewDecode<Account>(AccountDecoder()),
        onConnectionFailure: () {
          throw 'ConnectionFailure';
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
        onFailure: (FailureFrame failure, int status) {
          throw failure.estela.system;
        },
        onSuccess: (SuccessFrame<MigrationView<Account>> success) {
          MigrationView<Account> fact = success.estela;

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
