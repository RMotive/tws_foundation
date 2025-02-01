

import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../integration_credentials.dart';

void main() {
  late String auth;
  late PermitsServiceBase service;

  setUp(
    () async {
      final TWSFoundationSource source = TWSFoundationSource(
        false,
        headers: <String, String>{
          'CSMDisposition': 'Quality',
        },
      );


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

      service = source.permits;
    },
  );

  test(
    'View',
    () async {

      MainResolver<SetViewOut<Permit>> fact = await service.view(
        SetViewOptions<Permit>(false, 10, 1, null, <SetViewOrderOptions>[], <SetViewFilterNodeInterface<Permit>>[]),
        auth,
      );
      fact.resolve(
        decoder: (JObject json) => SetViewOut<Permit>.des(json, Permit.des),
        onConnectionFailure: () {
          throw 'ConnectionFailure';
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
        onFailure: (FailureFrame failure, int status) {
          throw failure.estela.system;
        },
        onSuccess: (SuccessFrame<SetViewOut<Permit>> success) {
          SetViewOut<Permit> fact = success.estela;

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
