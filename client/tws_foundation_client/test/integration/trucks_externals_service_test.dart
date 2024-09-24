import 'dart:math';

import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../integration_credentials.dart';

void main() {
  late String auth;
  late TrucksExternalsServiceBase service;
  late List<TruckExternal> mocks;

  TruckExternal buildExternalTruck(String randomToken){
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
      MainResolver<Privileges> resolver = await source.security.authenticate(testCredentials);
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

      service = source.trucksExternals;
      mocks = <TruckExternal>[];
      for (int i = 0; i < 3; i++) {
        int rnd = Random().nextInt(900)  + 99;
        String randomToken = '${i}_qual$rnd';
        TruckExternal mock = buildExternalTruck(randomToken);
        mocks.add(mock);
      }
    },
  );

  test(
    'View',
    () async {
      MainResolver<MigrationView<TruckExternal>> fact = await service.view(
        MigrationViewOptions(null, <MigrationViewOrderOptions>[], 1, 10, false),
        auth,
      );
      fact.resolve(
        decoder: MigrationViewDecode<TruckExternal>(TruckExternalDecoder()),
        onConnectionFailure: () {
          throw 'ConnectionFailure';
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
        onFailure: (FailureFrame failure, int status) {
          throw failure.estela.system;
        },
        onSuccess: (SuccessFrame<MigrationView<TruckExternal>> success) {
          MigrationView<TruckExternal> fact = success.estela;

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
      MainResolver<MigrationTransactionResult<TruckExternal>> fact = await service.create(mocks, auth);

      bool resolved = false;
      fact.resolve(
        decoder: MigrationTransactionResultDecoder<TruckExternal>(TruckExternalDecoder()),
        onException: (Object exception, StackTrace trace) => throw exception,
        onConnectionFailure: () => throw Exception('Connection failure'),
        onFailure: (FailureFrame failure, int status) => throw Exception(failure.estela.advise),
        onSuccess: (SuccessFrame<MigrationTransactionResult<TruckExternal>> success) {
          resolved = true;
        },
      );

      expect(true, resolved, reason: 'The action wasn\'t resolved');
    },
  );

  group(
    'Update',
    () {
      final MigrationUpdateResultDecoder<TruckExternal> decoder = MigrationUpdateResultDecoder<TruckExternal>(TruckExternalDecoder());
      late TruckExternal creationMock;
      test(
        'Creates when unexist',
        () async {
          int rnd = Random().nextInt(900)  + 99;
          TruckExternal mock = buildExternalTruck("U_qual$rnd");

          MainResolver<MigrationUpdateResult<TruckExternal>> fact = await service.update(mock, auth);
          MigrationUpdateResult<TruckExternal> actEffect = await fact.act(decoder);
          assert(actEffect.previous == null);
          assert(actEffect.updated.id > 0);

          creationMock = actEffect.updated;
        },
      );

      test(
        'Updates when exist',
        () async {
          int rnd = Random().nextInt(900)  + 99;
          TruckExternal mock = creationMock.clone(vin: "UPDATEDVIN_T: $rnd");
          mock.truckCommonNavigation!.economic = "UPDTECONOMIC:$rnd";
          MainResolver<MigrationUpdateResult<TruckExternal>> fact = await service.update(mock, auth);
          MigrationUpdateResult<TruckExternal> actEffect = await fact.act(decoder);
          assert(actEffect.previous != null);
          assert(actEffect.updated.id == creationMock.id);
          assert(actEffect.updated.vin != null);
          assert(actEffect.updated.truckCommonNavigation!.economic != actEffect.previous!.truckCommonNavigation!.economic);

        },
      );
    },
  );
}
