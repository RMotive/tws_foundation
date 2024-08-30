import 'dart:math';

import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../secrets/credentials.dart';

void main() {
  late String auth;
  late YardLogServiceBase service;
  late List<YardLog> mocks;

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

      service = source.yardLogs;
      mocks = <YardLog>[];
      for (int i = 0; i < 3; i++) {
        int rnd = Random().nextInt(900)  + 99;
        String randomToken = '${i}_qual$rnd';
        bool first = i == 0;
        DateTime time = DateTime.now();
        Plate plateMX = Plate(
          0, //id
          1, //status
          "MEX$randomToken",//identifier 
          "TIJ", //state
          "MEX", //country
          time, //expiration
          0, //truck
          null, //trailer
          null, //statusNavigation
          null, //truckCommonNavigation
          null //trailerCommonNavigation
        );
        Plate plateUSA = Plate(
          0, //id
          1, //status
          "USA$randomToken",//identifier 
          "CA", //state
          "USA", //country
          time, //expiration
          0, //truck
          null, //trailer
          null, //statusNavigation
          null, //truckCommonNavigation
          null //trailerCommonNavigation
        );
        Plate plateMX2 = Plate(
          0, //id
          1, //status
          "MEX$randomToken",//identifier 
          "TIJ", //state
          "MEX", //country
          time, //expiration
          null, //truck
          0, //trailer
          null, //statusNavigation
          null, //truckCommonNavigation
          null //trailerCommonNavigation
        );
        Plate plateUSA2 = Plate(
          0, //id
          1, //status
          "USA$randomToken",//identifier 
          "CA", //state
          "USA", //country
          time, //expiration
          null, //truck
          0, //trailer
          null, //statusNavigation
          null, //truckCommonNavigation
          null //trailerCommonNavigation
        );
        TrailerCommon trailerCommon = TrailerCommon(
          0, //id
          1, //status
          1, //trailerClass 
          1, //carrier 
          1, //situation
          null, //location
          "ECT$randomToken", //economic
          null //statusNavigation
          
        );
        Trailer trailer = Trailer(
          0, //id
          1, //status
          0, //common
          1, //manufactuer
          1, //maintenance
          trailerCommon, //trailerCommonNavigation 
          null, //statusNavigation
          <Plate>[plateMX2,plateUSA2] //plates
        );
        TruckCommon truckCommon = TruckCommon(
        0, //id
        1, //status
        1, //carrier
        "VINtest-$randomToken", //vin
        "ECO$randomToken", //economic
        null, //location
        1, //situation
        null, //statusNavigation
        null
        );
        Truck truck = Truck(
          0, // id 
          1, //Status
          2,//manufacturer
          0, //common
          "Motor $randomToken", //motor
          i, //maintenance
          i, //insurance
          null, //statusNavigation
          null, //manufacturerNavigation
          truckCommon, //truckCommonNavigation
          null, //maintenanceNavigation
          null, //insuranceNavigation
          <Plate>[plateMX,plateUSA] //plates
        );
        YardLog mock = YardLog(
          0, // ID
          true, //Entry
          first? 1 : 0, // Truck? Id
          null, // truckExternal
          first? 1 : 0, // trailer
          null, // trailerExternal
          first? 1 : 2, // loadType
          1, // section
          1, // driver
          null, // driverExternal
          null, // timestamp
          1, // guard
          "Guard $randomToken", // gName
          "Los angeles $randomToken", // fromTo
          "seal $randomToken", //seal
          false, //damage
          "Truck picture $randomToken", //ttPicture
          null, // dmgEvidence
          null, //driverNavigation
          null, //driverExternalNavigation
          first? null : truck, //truckNavigation
          null, //truckExternalNavigation
          first? null : trailer, //trailerNavigation
          null, //trailerExternalNavigation
          null, //loadTypeNavigation
          null, //sectionNavigation
          null
        );
        mocks.add(mock);
      }
    },
  );

  test(
    'View',
    () async {
      MainResolver<MigrationView<YardLog>> fact = await service.view(
        MigrationViewOptions(null, <MigrationViewOrderOptions>[], 1, 10, false),
        auth,
      );
      fact.resolve(
        decoder: MigrationViewDecode<YardLog>(YardLogDecoder()),
        onConnectionFailure: () {
          throw 'ConnectionFailure';
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
        onFailure: (FailureFrame failure, int status) {
          throw failure.estela.system;
        },
        onSuccess: (SuccessFrame<MigrationView<YardLog>> success) {
          MigrationView<YardLog> fact = success.estela;

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
      MainResolver<MigrationTransactionResult<YardLog>> fact = await service.create(mocks, auth);

      bool resolved = false;
      fact.resolve(
        decoder: MigrationTransactionResultDecoder<YardLog>(YardLogDecoder()),
        onException: (Object exception, StackTrace trace) => throw exception,
        onConnectionFailure: () => throw Exception('Connection failure'),
        onFailure: (FailureFrame failure, int status) => throw Exception(failure.estela.advise),
        onSuccess: (SuccessFrame<MigrationTransactionResult<YardLog>> success) {
          resolved = true;
        },
      );

      expect(true, resolved, reason: 'The action wasn\'t resolved');
    },
  );

  group(
    'Update',
    () {
      final MigrationUpdateResultDecoder<YardLog> decoder = MigrationUpdateResultDecoder<YardLog>(YardLogDecoder());
      late YardLog creationMock;
      test(
        'Creates when unexist',
        () async {
          int rnd = Random().nextInt(900)  + 99;
          String randomToken = '_quali$rnd';
          YardLog mock = YardLog(
            0, // ID
            true, //Entry
            1, // Truck? Id
            null, // truckExternal
            1, // trailer
            null, // trailerExternal
            1, // loadType
            1, // section
            1, // driver
            null, // driverExternal
            null, // timestamp
            1, // guard
            "Guard $randomToken", // gName
            "Los angeles $randomToken", // fromTo
            "seal $randomToken", //seal
            false, //damage
            "Truck picture $randomToken", //ttPicture
            null, // dmgEvidence
            null, //driverNavigation
            null, //driverExternalNavigation
            null, //truckNavigation
            null, //truckExternalNavigation
            null, //trailerNavigation
            null, //trailerExternalNavigation
            null, //loadTypeNavigation
            null, //sectionNavigation
            null
          );

          MainResolver<MigrationUpdateResult<YardLog>> fact = await service.update(mock, auth);
          MigrationUpdateResult<YardLog> actEffect = await fact.act(decoder);
          assert(actEffect.previous == null);
          assert(actEffect.updated.id > 0);

          creationMock = actEffect.updated;
        },
      );

      test(
        'Updates when exist',
        () async {
          YardLog mock = creationMock.clone(gName: 'a new name to test');
          mock.timestamp = null;
          MainResolver<MigrationUpdateResult<YardLog>> fact = await service.update(mock, auth);
          MigrationUpdateResult<YardLog> actEffect = await fact.act(decoder);
          assert(actEffect.previous != null);
          assert(actEffect.updated.id == creationMock.id);
        },
      );
    },
  );
}
