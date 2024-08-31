import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../integration_credentials.dart';

void main() {
  late final SecurityServiceBase service;

  setUp(
    () {
      service = TWSAdministrationSource(true).security;
    },
  );

  test(
    'Authenticate',
    () async {
      MainResolver<Privileges> fact = await service.authenticate(testCredentials);

      fact.resolve(
        decoder: PrivilegesDecode(),
        onConnectionFailure: () {
          throw 'ConnectionFailure';
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
        onFailure: (FailureFrame failure, int status) {
          throw failure;
        },
        onSuccess: (SuccessFrame<Privileges> success) {
          expect(success.estela.identity, testCredentials.identity);
        },
      );
    },
  );
}
