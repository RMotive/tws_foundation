import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../secrets/credentials.dart';

void main() {
  late String auth;
  late TrailersServiceBase service;
  setUp(
    () async {
      final TWSAdministrationSource source = TWSAdministrationSource(false);
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

      service = source.trailers;
    },
  );

  test(
    'View',
    () async {
      MainResolver<MigrationView<Trailer>> fact = await service.view(
        MigrationViewOptions(null, <MigrationViewOrderOptions>[], 1, 10, false),
        auth,
      );
      fact.resolve(
        decoder: MigrationViewDecode<Trailer>(TrailerDecoder()),
        onConnectionFailure: () {
          throw 'ConnectionFailure';
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
        onFailure: (FailureFrame failure, int status) {
          throw failure.estela.system;
        },
        onSuccess: (SuccessFrame<MigrationView<Trailer>> success) {
          MigrationView<Trailer> fact = success.estela;

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