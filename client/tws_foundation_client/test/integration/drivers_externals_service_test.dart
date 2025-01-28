import 'dart:math';

import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../integration_credentials.dart';

void main() {
  late String auth;
  late DriversExternalsServiceBase service;
  late List<DriverExternal> mocks;

  DriverExternal buildMock(String randomToken) {
    DateTime time = DateTime.now();
    DriverExternal mock = DriverExternal(
      0, 
      1, 
      0, 
      0, 
      DriverCommon(
        0, 
        1, 
        "licencia $randomToken", 
        null, 
        null,
        null,
      ), 
      Identification(
          0, 
          1, 
          "name_testing_$randomToken", 
          "fatherlastname_testing_$randomToken", 
          "motherlastname_testing_$randomToken", 
          time, 
          null,
        ), 
      null
    );
    
    return mock;
  }

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

      service = source.driversExternals;
    },
  );

  test(
    'View',
    () async {
      MainResolver<SetViewOut<DriverExternal>> fact = await service.view(
        SetViewOptions<DriverExternal>(false, 10, 1, null, <SetViewOrderOptions>[], <SetViewFilterNodeInterface<DriverExternal>>[]),
        auth,
      );
      fact.resolve(
        decoder: (JObject json) => SetViewOut<DriverExternal>.des(json, DriverExternal.des),
        onConnectionFailure: () {
          throw 'ConnectionFailure';
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
        onFailure: (FailureFrame failure, int status) {
          throw failure.estela.system;
        },
        onSuccess: (SuccessFrame<SetViewOut<DriverExternal>> success) {
          SetViewOut<DriverExternal> fact = success.estela;

          expect(fact.amount >= fact.records, true);
          expect(fact.records >= 0, true);
          expect(fact.page, 1);
          expect(fact.pages >= fact.page, true);
          expect(fact.sets.length, fact.records);
        },
      );
      mocks = <DriverExternal>[];
      for (int i = 0; i < 3; i++) {
        int rnd = Random().nextInt(900)  + 99;
        String randomToken = '${i}_qual$rnd';
        DriverExternal mock = buildMock(randomToken);
        mocks.add(mock);
      }
    },
  );

  test(
    'Create',
    () async {
      MainResolver<SetBatchOut<DriverExternal>> fact = await service.create(mocks, auth);
      bool resolved = false;
      fact.resolve(
        decoder: (JObject json) => SetBatchOut<DriverExternal>.des(json, DriverExternal.des),
        onException: (Object exception, StackTrace trace) => throw exception,
        onConnectionFailure: () => throw Exception('Connection failure'),
        onFailure: (FailureFrame failure, int status) => throw Exception(failure.estela.advise),
        onSuccess: (SuccessFrame<SetBatchOut<DriverExternal>> success) {
          resolved = true;
        },
      );

      expect(true, resolved, reason: 'The action wasn\'t resolved');
    },
  );

  group(
    'Update',
    () {
      late DriverExternal creationMock;
      test(
        'Creates when unexist',
        () async {
          int rnd = Random().nextInt(900)  + 99;
          DriverExternal mock = buildMock("$rnd");

          MainResolver<RecordUpdateOut<DriverExternal>> fact = await service.update(mock, auth);
          RecordUpdateOut<DriverExternal> actEffect = await fact.act((JObject json) =>  RecordUpdateOut<DriverExternal>.des(json, DriverExternal.des));
          assert(actEffect.previous == null);
          assert(actEffect.updated.id > 0);

          creationMock = actEffect.updated;
        },
      );

      test(
        'Updates when exist',
        () async {
          int rnd = Random().nextInt(900)  + 99;
          creationMock.driverCommonNavigation!.license = 'UPDT_lic_$rnd';
          creationMock.identificationNavigation!.name = 'UPDT_name_$rnd';
          MainResolver<RecordUpdateOut<DriverExternal>> fact = await service.update(creationMock, auth);
          RecordUpdateOut<DriverExternal> actEffect = await fact.act((JObject json) =>  RecordUpdateOut<DriverExternal>.des(json ,DriverExternal.des));
          assert(actEffect.previous != null);
          assert(actEffect.updated.id == creationMock.id);
          assert(actEffect.updated.driverCommonNavigation!.license != actEffect.previous!.driverCommonNavigation!.license);
          assert(actEffect.updated.identificationNavigation!.name != actEffect.previous!.identificationNavigation!.name);

        },
      );
    },
  );
}
