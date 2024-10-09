

import 'dart:math';

import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../integration_credentials.dart';

void main() {
  late String auth;
  late TrucksServiceBase service;
  late List<Truck> mocks;
  
  Truck buildMock(String randomToken){
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
      approach, 
      address, 
      usdot, 
      null, 
      <Truck>[]
    );
    Truck mock = Truck(
      0, // id 
      1, //Status
      0,//manufacturer
      0, //common
      1, //carrier
      "Motor $randomToken", //motor
      "VINtest-$randomToken", //vin
      null, //maintenance
      null, //insurance
      null,
      null, //statusNavigation
      model, //manufacturerNavigation
      truckCommon, //truckCommonNavigation
      maintenance, //maintenanceNavigation
      insurance, //insuranceNavigation
      sct, //sct
      carrier, //carrierNavigation
      <Plate>[plateMX,plateUSA]
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

      service = source.trucks;
      mocks = <Truck>[];
      for (int i = 0; i < 3; i++) {
        int rnd = Random().nextInt(900)  + 99;
        String randomToken = '${i}_qual$rnd';
        Truck mock = buildMock(randomToken);
        mocks.add(mock);
      }
    },
  );

  

  test(
    'View',
    () async {
      MainResolver<SetViewOut<Truck>> fact = await service.view(
        SetViewOptions<Truck>(false, 10, 1, null, <SetViewOrderOptions>[], <SetViewFilterNodeInterface<Truck>>[]),
        auth,
      );
      fact.resolve(
        decoder: (JObject json) => SetViewOut<Truck>.des(json,Truck.des),
        onConnectionFailure: () {
          throw 'ConnectionFailure';
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
        onFailure: (FailureFrame failure, int status) {
          throw failure.estela.system;
        },
        onSuccess: (SuccessFrame<SetViewOut<Truck>> success) {
          SetViewOut<Truck> fact = success.estela;

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
      MainResolver<SetBatchOut<Truck>> fact = await service.create(mocks, auth);

      bool resolved = false;
      fact.resolve(
        decoder:  (JObject json) => SetBatchOut<Truck>.des(json,Truck.des),
        onException: (Object exception, StackTrace trace) => throw exception,
        onConnectionFailure: () => throw Exception('Connection failure'),
        onFailure: (FailureFrame failure, int status) => throw Exception(failure.estela.advise),
        onSuccess: (SuccessFrame<SetBatchOut<Truck>> success) {
          resolved = true;
        },
      );

      expect(true, resolved, reason: 'The action wasn\'t resolved');
    },
  );

  group(
    'Update',
    () {
      late Truck creationMock;
      test(
        'Creates when unexist',
        () async {
          int rnd = Random().nextInt(900)  + 99;
          Truck mock = buildMock("U_qual$rnd");

          MainResolver<RecordUpdateOut<Truck>> fact = await service.update(mock, auth);
          RecordUpdateOut<Truck> actEffect = await fact.act((JObject json) =>  RecordUpdateOut<Truck>.des(json ,Truck.des));
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
          mock.vehiculeModelNavigation!.name = "manufacturer $rnd";
          MainResolver<RecordUpdateOut<Truck>> fact = await service.update(mock, auth);
          RecordUpdateOut<Truck> actEffect = await fact.act((JObject json) =>  RecordUpdateOut<Truck>.des(json ,Truck.des));
          assert(actEffect.previous != null);
          assert(actEffect.updated.id == creationMock.id);
          assert(actEffect.updated.vin != actEffect.previous!.vin);
          assert(actEffect.updated.vehiculeModelNavigation!.name != actEffect.previous!.vehiculeModelNavigation!.name);
        },
      );
    },
  );
}