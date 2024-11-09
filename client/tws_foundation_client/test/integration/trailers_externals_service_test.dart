import 'dart:math';

import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../integration_credentials.dart';

void main() {
  late String auth;
  late TrailersExternalsServiceBase service;
  late List<TrailerExternal> mocks;

  TrailerExternal buildMock(String randomToken) {
    TrailerExternal mock = TrailerExternal(
      0,
      1,
      0,
      "carrier external $randomToken",
      "mx$randomToken",
      "us$randomToken",
      TrailerCommon(
        0,
        1,
        null,
        null,
        null,
        "ETO$randomToken",
        null,
        null,
        null,
        null,
      ),
      null,
    );
    return mock;
  }
  
  setUp(
    () async {
      final TWSFoundationSource source = TWSFoundationSource(false);
      MainResolver<Privileges> resolver = await source.security.authenticate(testCredentials);
      resolver.resolve(
        decoder: Privileges.des,
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

      service = source.trailersExternals;
      mocks = <TrailerExternal>[];
      for (int i = 0; i < 3; i++) {
        int rnd = Random().nextInt(900)  + 99;
        String randomToken = '${i}_qual$rnd';
        TrailerExternal mock = buildMock(randomToken);
        mocks.add(mock);
      }
    },
  );

  test(
    'View',
    () async {
      MainResolver<SetViewOut<TrailerExternal>> fact = await service.view(
        SetViewOptions<TrailerExternal>(false, 10, 1, null, <SetViewOrderOptions>[], <SetViewFilterNodeInterface<TrailerExternal>>[]),
        auth,
      );
      fact.resolve(
        decoder: (JObject json) => SetViewOut<TrailerExternal>.des(json, TrailerExternal.des),
        onConnectionFailure: () {
          throw 'ConnectionFailure';
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
        onFailure: (FailureFrame failure, int status) {
          throw failure.estela.system;
        },
        onSuccess: (SuccessFrame<SetViewOut<TrailerExternal>> success) {
          SetViewOut<TrailerExternal> fact = success.estela;

          expect(fact.amount >= fact.records, true);
          expect(fact.records >= 0, true);
          expect(fact.page, 1);
          expect(fact.pages >= fact.page, true);
          expect(fact.sets.length, fact.records);
        },
      );
    },
  );
  test(
    'Create',
    () async {
      MainResolver<SetBatchOut<TrailerExternal>> fact =
          await service.create(mocks, auth);

      bool resolved = false;
      fact.resolve(
        decoder: (JObject json) => SetBatchOut<TrailerExternal>.des(json, TrailerExternal.des),
        onException: (Object exception, StackTrace trace) => throw exception,
        onConnectionFailure: () => throw Exception('Connection failure'),
        onFailure: (FailureFrame failure, int status) =>
            throw Exception(failure.estela.advise),
        onSuccess: (SuccessFrame<SetBatchOut<TrailerExternal>> success) {
          resolved = true;
        },
      );

      expect(true, resolved, reason: 'The action wasn\'t resolved');
    },
  );

  group(
    'Update',
    () {
      late TrailerExternal creationMock;
      test(
        'Creates when unexist',
        () async {
          int rnd = Random().nextInt(900)  + 99;
          TrailerExternal mock = buildMock("U_qual$rnd");

          MainResolver<RecordUpdateOut<TrailerExternal>> fact = await service.update(mock, auth);
          RecordUpdateOut<TrailerExternal> actEffect = await fact.act((JObject json) =>  RecordUpdateOut<TrailerExternal>.des(json ,TrailerExternal.des));
          assert(actEffect.previous == null);
          assert(actEffect.updated.id > 0);

          creationMock = actEffect.updated;
        },
      );

      test(
        'Updates when exist',
        () async {
          int rnd = Random().nextInt(900)  + 99;
          creationMock.trailerCommonNavigation!.economic = "updated econ $rnd";
          MainResolver<RecordUpdateOut<TrailerExternal>> fact = await service.update(creationMock, auth);
          RecordUpdateOut<TrailerExternal> actEffect = await fact.act((JObject json) =>  RecordUpdateOut<TrailerExternal>.des(json ,TrailerExternal.des));
          assert(actEffect.previous != null);
          assert(actEffect.updated.id == creationMock.id);
          assert(actEffect.updated.trailerCommonNavigation!.economic != actEffect.previous!.trailerCommonNavigation!.economic);
        },
      );
    },
  );
}
