import 'dart:math';

import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../integration_credentials.dart';

void main() {
  late String auth;
  late TrailersServiceBase service;
  late List<Trailer> mocks;

  Trailer buildMock(String randomToken) {
    DateTime time = DateTime.now();
    Trailer mock = Trailer(
      0, //id
      1, //status,
      0, //common,
      0, //carrier,
      null, //sct
      null, //model
      null, //maintenance
      Carrier(
        0,
        1,
        0,
        0,
        "Carrier: $randomToken",
        "Carrier description: $randomToken",
        null,
        Approach(
          0,
          1,
          "Testemail@$randomToken.com",
          null,
          null,
          null,
          null,
          <Carrier>[],
        ),
        Address(
          0,
          "USA",
          null,
          null,
          null,
          null,
          null,
          null,
          <Carrier>[],
        ),
        USDOT(0, 1, "MCtestT", "scac", null),
        null,
        <Truck>[],
      ),
      SCT(
        0,
        1,
        "type01",
        "Number_test_sct:$randomToken",
        "C$randomToken",
        null,
      ),
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
      null,
      null, // status nav
      <Plate>[
        Plate(
          0, //id
          1, //status
          "MEX$randomToken", //identifier
          "TIJ", //state
          "MEX", //country
          time, //expiration
          null, //truck
          null, //trailer
          null, //statusNavigation
          null, //truckCommonNavigation
          null, //trailerCommonNavigation
        ),
        Plate(
          0, //id
          1, //status
          "USA$randomToken", //identifier
          "CA", //state
          "USA", //country
          time, //expiration
          null, //truck
          null, //trailer
          null, //statusNavigation
          null, //truckCommonNavigation
          null, //trailerCommonNavigation
        ),
      ],
    );
    return mock;
  }

  setUp(
    () async {
      final TWSFoundationSource source = TWSFoundationSource(false);
      MainResolver<Privileges> resolver =
          await source.security.authenticate(testCredentials);
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

      service = source.trailers;
      mocks = <Trailer>[];
      for (int i = 0; i < 3; i++) {
        int rnd = Random().nextInt(900)  + 99;
        String randomToken = '${i}_qual$rnd';
        Trailer mock = buildMock(randomToken);
        mocks.add(mock);
      }
    },
  );

  test(
    'View',
    () async {
      MainResolver<SetViewOut<Trailer>> fact = await service.view(
        SetViewOptions<Trailer>(false, 10, 1, null, <SetViewOrderOptions>[],
            <SetViewFilterNodeInterface<Trailer>>[]),
        auth,
      );
      fact.resolve(
        decoder: (JObject json) => SetViewOut<Trailer>.des(json, Trailer.des),
        onConnectionFailure: () {
          throw 'ConnectionFailure';
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
        onFailure: (FailureFrame failure, int status) {
          throw failure.estela.system;
        },
        onSuccess: (SuccessFrame<SetViewOut<Trailer>> success) {
          SetViewOut<Trailer> fact = success.estela;

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
      MainResolver<SetBatchOut<Trailer>> fact =
          await service.create(mocks, auth);

      bool resolved = false;
      fact.resolve(
        decoder: (JObject json) => SetBatchOut<Trailer>.des(json, Trailer.des),
        onException: (Object exception, StackTrace trace) => throw exception,
        onConnectionFailure: () => throw Exception('Connection failure'),
        onFailure: (FailureFrame failure, int status) =>
            throw Exception(failure.estela.advise),
        onSuccess: (SuccessFrame<SetBatchOut<Trailer>> success) {
          resolved = true;
        },
      );

      expect(true, resolved, reason: 'The action wasn\'t resolved');
    },
  );

  group(
    'Update',
    () {
      late Trailer creationMock;
      test(
        'Creates when unexist',
        () async {
          int rnd = Random().nextInt(900)  + 99;
          Trailer mock = buildMock("U_qual$rnd");

          MainResolver<RecordUpdateOut<Trailer>> fact = await service.update(mock, auth);
          RecordUpdateOut<Trailer> actEffect = await fact.act((JObject json) =>  RecordUpdateOut<Trailer>.des(json ,Trailer.des));
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
          MainResolver<RecordUpdateOut<Trailer>> fact = await service.update(creationMock, auth);
          RecordUpdateOut<Trailer> actEffect = await fact.act((JObject json) =>  RecordUpdateOut<Trailer>.des(json ,Trailer.des));
          assert(actEffect.previous != null);
          assert(actEffect.updated.id == creationMock.id);
          assert(actEffect.updated.trailerCommonNavigation!.economic != actEffect.previous!.trailerCommonNavigation!.economic);
        },
      );
    },
  );
}
