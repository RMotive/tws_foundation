import 'dart:math';

import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../integration_credentials.dart';

void main() {
  late String auth;
  late YardLogServiceBase service;
  late List<YardLog> mocks; 
  
  YardLog buildMock(String randomToken){
    DateTime time = DateTime.now();
    Plate plateMX = Plate(
      0, //id
      1, //status
      "MEX$randomToken", //identifier
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
      "USA$randomToken", //identifier
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
      "MEX$randomToken", //identifier
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
      "USA$randomToken", //identifier
      "CA", //state
      "USA", //country
      time, //expiration
      null, //truck
      0, //trailer
      null, //statusNavigation
      null, //truckCommonNavigation
      null //trailerCommonNavigation
    );
    TrailerClass trailerClass = TrailerClass(
      0, 
      "trailer class: $randomToken", 
      null
    );
    TrailerType trailerType = TrailerType(
      0, 
      1,
      0,
      "48FT", 
      null, 
      trailerClass
    );
    TrailerCommon trailerCommon = TrailerCommon(
      0, //id
      1, //status
      0, //type
      1, //situation
      null, //location
      "ECT$randomToken", //economic
      trailerType,
      null, //statusNavigation
    );
    
    Trailer trailer = Trailer(
      0, //id
      1, //status
      0, //common
      1, //carrier
      null, //model
      1, //maintenance
      null,
      trailerCommon, //trailerCommonNavigation
      null, //vehiculeModelNavigation
      null, //statusNavigation
      <Plate>[plateMX2, plateUSA2] //plates
    );
    TruckCommon truckCommon = TruckCommon(
    0, //id
    1, //status
    "ECO$randomToken", //economic
    null, //location
    1, //situation
    null, //statusNavigation
    null,
    null
    );
    Manufacturer manufacturer = Manufacturer(
      0, 
      "manufacturer $randomToken",
      null
    );
    VehiculeModel model = VehiculeModel(
      0, 
      1, 
      0, 
      "Model name $randomToken", 
      DateTime.now(), 
      null, 
      manufacturer
    );
    Truck truck = Truck(
      0, // id
      1, //Status
      0, //model
      0, //common
      1, //carrier
      "Motor $randomToken", //motor
      "VINtest-$randomToken", //vin
      null, //maintenance
      null, //insurance
      null, //sct
      null, //statusNavigation
      model, //modelNavigation
      truckCommon, //truckCommonNavigation
      null, //maintenanceNavigation
      null, //insuranceNavigation
      null, //sct
      null, //carrierNavigation
      <Plate>[plateMX, plateUSA] //plates
    );
    YardLog mock = YardLog(
      0, // ID
      true, //Entry
      0, // Truck? Id
      null, // truckExternal
      0, // trailer
      null, // trailerExternal
      1, // loadType
      1, // section
      1, // driver
      null, // driverExternal
      1, // guard
      "Guard $randomToken", // gName
      "Los angeles $randomToken", // fromTo
      "seal $randomToken", //seal
      false, //damage
      "Truck picture $randomToken", //ttPicture
      null, // dmgEvidence
      null, //driverNavigation
      null, //driverExternalNavigation
      truck, //truckNavigation
      null, //truckExternalNavigation
      trailer, //trailerNavigation
      null, //trailerExternalNavigation
      null, //loadTypeNavigation
      null, //sectionNavigation
      null
    );
    List<CSMSetValidationResult> evaluation = mock.evaluate();
    assert(evaluation.isEmpty);
    return mock;
  }

  setUp(
    () async {
      final TWSFoundationSource source = TWSFoundationSource(true);
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

      service = source.yardLogs;
      mocks = <YardLog>[];
      for (int i = 0; i < 3; i++) {
        int rnd = Random().nextInt(900) + 99;
        String randomToken = '${i}_qual$rnd';
        mocks.add(buildMock(randomToken));
      }
    }
  );
  test(
    'View',
    () async {
      MainResolver<SetViewOut<YardLog>> fact = await service.view(
        SetViewOptions<YardLog>(false, 10, 1, null, <SetViewOrderOptions>[], <SetViewFilterNodeInterface<YardLog>>[]),
        auth,
      );
      fact.resolve(
        decoder: SetViewOutDecode<YardLog>(YardLogDecoder()),
        onConnectionFailure: () {
          throw 'ConnectionFailure';
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
        onFailure: (FailureFrame failure, int status) {
          throw failure.estela.system;
        },
        onSuccess: (SuccessFrame<SetViewOut<YardLog>> success) {
          SetViewOut<YardLog> fact = success.estela;

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
          int rnd = Random().nextInt(900) + 99;
          String randomToken = '_quali$rnd';
          YardLog mock = buildMock(randomToken);

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
          MainResolver<MigrationUpdateResult<YardLog>> fact = await service.update(mock, auth);
          MigrationUpdateResult<YardLog> actEffect = await fact.act(decoder);
          assert(actEffect.previous != null);
          assert(actEffect.updated.id == creationMock.id);
          assert(actEffect.updated.gName == mock.gName);
        },
      );
    },
  );
}
