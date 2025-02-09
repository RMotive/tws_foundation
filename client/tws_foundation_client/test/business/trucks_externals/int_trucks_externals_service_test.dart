import 'dart:math';

import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../../integration_credentials.dart';

void main() {
  late String auth;
  late TrucksExternalsServiceBase service;
  late List<TruckExternal> mocks;

  TruckExternal buildExternalTruck(String randomToken) {
    TruckCommon truckCommon = TruckCommon(
      0, //id
      1, //status
      "ECO$randomToken", //economic
      null, //location
      null, //situation
      null, //locationNavigation
      null, //situationNavigation
      null, //statusNavigation
    );
    TruckExternal truckExternal = TruckExternal(
        0, //ID
        1, //Status
        0, //Common
        null, //VIN
        "Carrier $randomToken",
        "MEX$randomToken",
        "USA$randomToken",
        truckCommon,
        null //StatusNavigation
        );
    return truckExternal;
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

      service = source.trucksExternals;
      mocks = <TruckExternal>[];
      for (int i = 0; i < 3; i++) {
        int rnd = Random().nextInt(900) + 99;
        String randomToken = '${i}_qual$rnd';
        TruckExternal mock = buildExternalTruck(randomToken);
        List<CSMSetValidationResult> evaluation = mock.evaluate();
        assert(evaluation.isEmpty);
        mocks.add(mock);
      }
    },
  );

  test(
    'View',
    () async {
      MainResolver<SetViewOut<TruckExternal>> fact = await service.view(
        SetViewOptions<TruckExternal>(false, 10, 1, null, <SetViewOrderOptions>[], <SetViewFilterNodeInterface<TruckExternal>>[]),
        auth,
      );
      fact.resolve(
        decoder: (JObject json) => SetViewOut<TruckExternal>.des(json, TruckExternal.des),
        onConnectionFailure: () {
          throw 'ConnectionFailure';
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
        onFailure: (FailureFrame failure, int status) {
          throw failure.estela.system;
        },
        onSuccess: (SuccessFrame<SetViewOut<TruckExternal>> success) {
          SetViewOut<TruckExternal> fact = success.estela;

          expect(fact.count >= fact.length, true);
          expect(fact.length >= 0, true);
          expect(fact.page, 1);
          expect(fact.pages >= fact.page, true);
          expect(fact.records.length, fact.length);
        },
      );
    },
  );
  test(
    'Create',
    () async {
      MainResolver<SetBatchOut<TruckExternal>> fact = await service.create(mocks, auth);

      bool resolved = false;
      fact.resolve(
        decoder: (JObject json) => SetBatchOut<TruckExternal>.des(json, TruckExternal.des),
        onException: (Object exception, StackTrace trace) => throw exception,
        onConnectionFailure: () => throw Exception('Connection failure'),
        onFailure: (FailureFrame failure, int status) => throw Exception(failure.estela.advise),
        onSuccess: (SuccessFrame<SetBatchOut<TruckExternal>> success) {
          resolved = true;
        },
      );

      expect(true, resolved, reason: 'The action wasn\'t resolved');
    },
  );

  group(
    'Update',
    () {
      late TruckExternal creationMock;
      test(
        'Creates when unexist',
        () async {
          int rnd = Random().nextInt(900) + 99;
          TruckExternal mock = buildExternalTruck("U_qual$rnd");

          MainResolver<RecordUpdateOut<TruckExternal>> fact = await service.update(mock, auth);
          RecordUpdateOut<TruckExternal> actEffect = await fact.act((JObject json) => RecordUpdateOut<TruckExternal>.des(json, TruckExternal.des));
          assert(actEffect.previous == null);
          assert(actEffect.updated.id > 0);

          creationMock = actEffect.updated;
        },
      );

      test(
        'Updates when exist',
        () async {
          int rnd = Random().nextInt(900) + 99;
          TruckExternal mock = creationMock.clone(vin: "UPDATEDVIN_T: $rnd");
          mock.truckCommonNavigation!.economic = "UPDTECONOMIC:$rnd";
          MainResolver<RecordUpdateOut<TruckExternal>> fact = await service.update(mock, auth);
          RecordUpdateOut<TruckExternal> actEffect = await fact.act((JObject json) => RecordUpdateOut<TruckExternal>.des(json, TruckExternal.des));
          assert(actEffect.previous != null);
          assert(actEffect.updated.id == creationMock.id);
          assert(actEffect.updated.vin != null);
          assert(actEffect.updated.truckCommonNavigation!.economic != actEffect.previous!.truckCommonNavigation!.economic);
        },
      );
    },
  );
}
