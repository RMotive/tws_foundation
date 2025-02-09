import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../../integration_credentials.dart';

void main() {
  late final SecurityServiceBase service;

  setUp(
    () {
      service = TWSFoundationSource(true).security;
    },
  );

  test(
    'Authenticate',
    () async {
      MainResolver<Session> fact = await service.authenticate(testCredentials);

      fact.resolve(
        decoder: Session.des,
        onConnectionFailure: () {
          throw 'ConnectionFailure';
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
        onFailure: (FailureFrame failure, int status) {
          throw failure;
        },
        onSuccess: (SuccessFrame<Session> success) {
          expect(success.estela.identity, testCredentials.identity);
        },
      );
    },
  );
}
