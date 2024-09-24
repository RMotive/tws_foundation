

import 'dart:io';
import 'dart:math';

import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../integration_credentials.dart';

void main() {
  late String auth;
  late TrucksServiceBase service;
  late List<Truck> mocks;
  
  Truck buildTruck(String randomToken){
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
    TruckCommon truckCommon = TruckCommon(
      0, //id
      1, //status
      "ECO$randomToken", //economic
      null, //location
      null, //situation
      null,
      null,
      null, //statusNavigation
    );
    Maintenance maintenance = Maintenance(
      0, 
      1, 
      DateTime.now(), 
      DateTime.now(), 
      null, 
      <Truck>[]
    );
    Insurance insurance = Insurance(
      0, 
      1, 
      "P232Policy$randomToken", 
      DateTime.now(), 
      "USA", 
      null, 
      <Truck>[]
    );
    Manufacturer manufacturer = Manufacturer(
      0, 
      "model $randomToken", 
      "brand $randomToken", 
      DateTime.now(), 
      <Truck>[]
    );
    Approach approach = Approach(
      0, 
      1, 
      "Testemail@$randomToken.com", 
      null, 
      null, 
      null, 
      null, 
      <Carrier>[]
    );
    Address address = Address(
      0, 
      "USA", 
      null, 
      null, 
      null, 
      null, 
      null, 
      null, 
      <Carrier>[]
    );
    USDOT usdot = USDOT(
      0, 
      1, 
      "MCtestT", 
      "scac", 
      null
    );
    SCT sct = SCT(
      0, 
      1, 
      "type01", 
      "Number_test_sct:$randomToken", 
      "C$randomToken", 
      null
    );
    Carrier carrier = Carrier(
      0, 
      1, 
      0, 
      0, 
      "Carrier: $randomToken", 
      "Carrier description: $randomToken", 
      null, 
      null, 
      approach, 
      address, 
      usdot, 
      sct, 
      null, 
      <Truck>[]
    );
    Truck truck = Truck(
      0, // id 
      1, //Status
      0,//manufacturer
      0, //common
      1, //carrier
      "Motor $randomToken", //motor
      "VINtest-$randomToken", //vin
      null, //maintenance
      null, //insurance
      null, //statusNavigation
      manufacturer, //manufacturerNavigation
      truckCommon, //truckCommonNavigation
      maintenance, //maintenanceNavigation
      insurance, //insuranceNavigation
      carrier, //carrierNavigation
      <Plate>[plateMX,plateUSA]
    );
    return truck;
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

      service = source.trucks;
      mocks = <Truck>[];
      for (int i = 0; i < 3; i++) {
        int rnd = Random().nextInt(900)  + 99;
        String randomToken = '${i}_qual$rnd';
        Truck mock = buildTruck(randomToken);
        mocks.add(mock);
      }
    },
  );

  

  test(
    'View',
    () async {
      MainResolver<MigrationView<Truck>> fact = await service.view(
        MigrationViewOptions(null, <MigrationViewOrderOptions>[], 1, 10, false),
        auth,
      );
      fact.resolve(
        decoder: MigrationViewDecode<Truck>(TruckDecoder()),
        onConnectionFailure: () {
          throw 'ConnectionFailure';
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
        onFailure: (FailureFrame failure, int status) {
          throw failure.estela.system;
        },
        onSuccess: (SuccessFrame<MigrationView<Truck>> success) {
          MigrationView<Truck> fact = success.estela;

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
      MainResolver<MigrationTransactionResult<Truck>> fact = await service.create(mocks, auth);

      bool resolved = false;
      fact.resolve(
        decoder: MigrationTransactionResultDecoder<Truck>(TruckDecoder()),
        onException: (Object exception, StackTrace trace) => throw exception,
        onConnectionFailure: () => throw Exception('Connection failure'),
        onFailure: (FailureFrame failure, int status) => throw Exception(failure.estela.advise),
        onSuccess: (SuccessFrame<MigrationTransactionResult<Truck>> success) {
          resolved = true;
        },
      );

      expect(true, resolved, reason: 'The action wasn\'t resolved');
    },
  );

  group(
    'Update',
    () {
      final MigrationUpdateResultDecoder<Truck> decoder = MigrationUpdateResultDecoder<Truck>(TruckDecoder());
      late Truck creationMock;
      test(
        'Creates when unexist',
        () async {
          int rnd = Random().nextInt(900)  + 99;
          Truck mock = buildTruck("U_qual$rnd");

          MainResolver<MigrationUpdateResult<Truck>> fact = await service.update(mock, auth);
          MigrationUpdateResult<Truck> actEffect = await fact.act(decoder);
          assert(actEffect.previous == null);
          assert(actEffect.updated.id > 0);

          creationMock = actEffect.updated;
        },
      );

      test(
        'Updates when exist',
        () async {
          int rnd = Random().nextInt(900)  + 99;
          Truck mock = creationMock.clone(vin: "UPDATEDVIN_T: $rnd");
          mock.manufacturerNavigation!.brand = "brand $rnd";
          MainResolver<MigrationUpdateResult<Truck>> fact = await service.update(mock, auth);
          MigrationUpdateResult<Truck> actEffect = await fact.act(decoder);
          assert(actEffect.previous != null);
          assert(actEffect.updated.id == creationMock.id);
          assert(actEffect.updated.vin != actEffect.previous!.vin);
          assert(actEffect.updated.manufacturerNavigation!.brand != actEffect.previous!.manufacturerNavigation!.brand);

        },
      );
    },
  );
}