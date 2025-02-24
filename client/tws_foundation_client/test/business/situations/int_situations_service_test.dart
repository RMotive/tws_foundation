import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../../integration_credentials.dart';

void main() {
  late String auth;
  late SituationsServiceBase service;

  setUp(
    () async {
      final TWSFoundationSource source = TWSFoundationSource(false);
      MainResolver<Session> resolver = await source.security.authenticate(testCredentials);
      resolver.resolve(
        decoder: Session.des,
        onConnectionFailure: () {
          throw 'ConnectionFailure';
        },
        onFailure: (FailureFrame failure, int status) {
          throw failure;
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
        onSuccess: (SuccessFrame<Session> success) {
          auth = success.estela.token;
        },
      );

      service = source.situations;
    },
  );

  test(
    'View',
    () async {
      MainResolver<SetViewOut<Situation>> fact = await service.view(
        SetViewOptions<Situation>(false, 10, 1, null, <SetViewOrderOptions>[], <SetViewFilterNodeInterface<Situation>>[]),
        auth,
      );
      fact.resolve(
        decoder: (JObject json) => SetViewOut<Situation>.des(json, Situation.des),
        onConnectionFailure: () {
          throw 'ConnectionFailure';
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
        onFailure: (FailureFrame failure, int status) {
          throw failure.estela.system;
        },
        onSuccess: (SuccessFrame<SetViewOut<Situation>> success) {
          SetViewOut<Situation> fact = success.estela;

          expect(fact.count >= fact.length, true);
          expect(fact.length >= 0, true);
          expect(fact.page, 1);
          expect(fact.pages >= fact.page, true);
          expect(fact.records.length, fact.length);
        },
      );
    },
  );
}
