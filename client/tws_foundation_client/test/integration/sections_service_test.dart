import 'dart:math';

import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../integration_credentials.dart';

void main() {
  late String auth;
  late SectionsServiceBase service;
    late List<Section> mocks;


  Section buildMock(String randomToken){
    return Section(
      0,
      1,
      0,
      "Section $randomToken",
      99,
      0,
      Location(
        0,
        1,
        null,
        null,
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

      service = source.sections;
      mocks = <Section>[];
      for (int i = 0; i < 3; i++) {
        int rnd = Random().nextInt(900)  + 99;
        String randomToken = '${i}_qual$rnd';
        Section mock = buildMock(randomToken);
        mocks.add(mock);
      }
    },
  );

  test(
    'View',
    () async {
      MainResolver<SetViewOut<Section>> fact = await service.view(
        SetViewOptions<Section>(false, 10, 1, null, <SetViewOrderOptions>[], <SetViewFilterNodeInterface<Section>>[]),
        auth,
      );
      fact.resolve(
        decoder: (JObject json) => SetViewOut<Section>.des(json, Section.des),
        onConnectionFailure: () {
          throw 'ConnectionFailure';
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
        onFailure: (FailureFrame failure, int status) {
          throw failure.estela.system;
        },
        onSuccess: (SuccessFrame<SetViewOut<Section>> success) {
          SetViewOut<Section> fact = success.estela;

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
      MainResolver<SetBatchOut<Section>> fact =
          await service.create(mocks, auth);

      bool resolved = false;
      fact.resolve(
        decoder: (JObject json) => SetBatchOut<Section>.des(json, Section.des),
        onException: (Object exception, StackTrace trace) => throw exception,
        onConnectionFailure: () => throw Exception('Connection failure'),
        onFailure: (FailureFrame failure, int status) =>
            throw Exception(failure.estela.advise),
        onSuccess: (SuccessFrame<SetBatchOut<Section>> success) {
          resolved = true;
        },
      );

      expect(true, resolved, reason: 'The action wasn\'t resolved');
    },
  );

  group(
    'Update',
    () {
      late Section creationMock;
      test(
        'Creates when unexist',
        () async {
          int rnd = Random().nextInt(900)  + 99;
          Section mock = buildMock("U_qual$rnd");

          MainResolver<RecordUpdateOut<Section>> fact = await service.update(mock, auth);
          RecordUpdateOut<Section> actEffect = await fact.act((JObject json) =>  RecordUpdateOut<Section>.des(json ,Section.des));
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
          creationMock.locationNavigation!.name = 'UPDT $rnd';
          creationMock.locationNavigation!.addressNavigation!.country = 'MX';

          MainResolver<RecordUpdateOut<Section>> fact = await service.update(creationMock, auth);
          RecordUpdateOut<Section> actEffect = await fact.act((JObject json) =>  RecordUpdateOut<Section>.des(json ,Section.des));
          assert(actEffect.previous != null);
          assert(actEffect.updated.id == creationMock.id);
          assert(actEffect.updated.locationNavigation!.addressNavigation!.country != actEffect.previous!.locationNavigation!.addressNavigation!.country);
          assert(actEffect.updated.locationNavigation!.name != actEffect.previous!.locationNavigation!.name);

        },
      );
    },
  );
}
