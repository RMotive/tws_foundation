import 'dart:math';

import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../integration_credentials.dart';

void main() {
  late String auth;
  late LocationsServiceBase service;
    late List<Location> mocks;


  Location buildMock(String randomToken){
    return Location(
      0,
      1,
      0,
      0,
      "Location $randomToken",
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
        Waypoint(
          0,
          1,
          10.99,
          3.99,
          null,
          null,
        ),
      null,
    );
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

      service = source.locations;
      mocks = <Location>[];
      for (int i = 0; i < 3; i++) {
        int rnd = Random().nextInt(900)  + 99;
        String randomToken = '${i}_qual$rnd';
        Location mock = buildMock(randomToken);
        mocks.add(mock);
      }
    },
  );

  test(
    'View',
    () async {
      MainResolver<SetViewOut<Location>> fact = await service.view(
        SetViewOptions<Location>(false, 10, 1, null, <SetViewOrderOptions>[], <SetViewFilterNodeInterface<Location>>[]),
        auth,
      );
      fact.resolve(
        decoder: (JObject json) => SetViewOut<Location>.des(json, Location.des),
        onConnectionFailure: () {
          throw 'ConnectionFailure';
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
        onFailure: (FailureFrame failure, int status) {
          throw failure.estela.system;
        },
        onSuccess: (SuccessFrame<SetViewOut<Location>> success) {
          SetViewOut<Location> fact = success.estela;

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
      MainResolver<SetBatchOut<Location>> fact =
          await service.create(mocks, auth);

      bool resolved = false;
      fact.resolve(
        decoder: (JObject json) => SetBatchOut<Location>.des(json, Location.des),
        onException: (Object exception, StackTrace trace) => throw exception,
        onConnectionFailure: () => throw Exception('Connection failure'),
        onFailure: (FailureFrame failure, int status) =>
            throw Exception(failure.estela.advise),
        onSuccess: (SuccessFrame<SetBatchOut<Location>> success) {
          resolved = true;
        },
      );

      expect(true, resolved, reason: 'The action wasn\'t resolved');
    },
  );

  group(
    'Update',
    () {
      late Location creationMock;
      test(
        'Creates when unexist',
        () async {
          int rnd = Random().nextInt(900)  + 99;
          Location mock = buildMock("U_qual$rnd");

          MainResolver<RecordUpdateOut<Location>> fact = await service.update(mock, auth);
          RecordUpdateOut<Location> actEffect = await fact.act((JObject json) =>  RecordUpdateOut<Location>.des(json ,Location.des));
          assert(actEffect.previous == null);
          assert(actEffect.updated.id > 0);

          creationMock = actEffect.updated;
        },
      );

      test(
        'Updates when exist',
        () async {
          int rnd = Random().nextInt(900)  + 99;
          creationMock.name = 'UPDT $rnd';
          creationMock.addressNavigation!.country = 'MX';
          creationMock.waypointNavigation!.altitude = 4.99;

          MainResolver<RecordUpdateOut<Location>> fact = await service.update(creationMock, auth);
          RecordUpdateOut<Location> actEffect = await fact.act((JObject json) =>  RecordUpdateOut<Location>.des(json, Location.des));
          assert(actEffect.previous != null);
          assert(actEffect.updated.id == creationMock.id);
          assert(actEffect.updated.addressNavigation!.country != actEffect.previous!.addressNavigation!.country);
          assert(actEffect.updated.waypointNavigation!.altitude != actEffect.previous!.waypointNavigation!.altitude);

        },
      );
    },
  );
}
