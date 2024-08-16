import 'dart:math';
import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../secrets/credentials.dart';

void main() {
  late String auth;
  late TrucksServiceBase service;
  late List<Truck> mockList = <Truck>[];
  String testTag = '';
  DateTime time = DateTime.now();

  group("Truck Service - Integrarion Tests", () {
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
        int random = 10 + Random().nextInt(89);
        testTag = random.toString();
        service = source.trucks;
        mockList = <Truck>[];
        for (int i = 0; i < 3; i++) {
          String iterationTag = "$testTag$i";

          Manufacturer manufacturer = Manufacturer(0, "S23", "SCANIA_TEST$iterationTag", time, <Truck>[]);
          Situation situation = Situation(0, "Situational_test $iterationTag", "Description_test_$iterationTag", <Truck>[]);
          List<Plate> plates = <Plate>[Plate(0, "_xPlate$iterationTag", "ABC", "MXN", time, 0, null), Plate(0, "_saPlate$iterationTag", "Avv", "USA", time, 0, null)];
          Insurance insurance = Insurance(0, "_232Policy$iterationTag", time, "MEX", <Truck>[]);
          Maintenance maintenance = Maintenance(0, time, time, <Truck>[]);
          SCT sct = SCT(0, "_yp$iterationTag", "NumberSCTTesting_value$iterationTag", "con_$iterationTag", <Truck>[]);
          Truck mock = Truck(
              0,
              "VINnumber_test$iterationTag",
              0,
              "Motor_number_$iterationTag",
              null,
              null,
              null,
              null,
              manufacturer, //manufactuer
              sct,
              maintenance,
              situation,
              insurance,
              plates);
          for (CSMSetValidationResult validation in mock.evaluate()) {
            print(validation.reason);
          }
          mockList.add(mock);
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
      "Create full set",
      () async {
        MainResolver<MigrationTransactionResult<Truck>> fact = await service.create(mockList, auth);
        bool passed = false;
        fact.resolve(
          decoder: MigrationTransactionResultDecoder<Truck>(TruckDecoder()),
          onConnectionFailure: () {
            throw 'ConnectionFailure';
          },
          onFailure: (FailureFrame failure, int status) {
            assert(false, 'server returned a success $status');
          },
          onException: (Object exception, StackTrace trace) {
            assert(false, 'server returned a success');
          },
          onSuccess: (SuccessFrame<MigrationTransactionResult<Truck>> success) {
            passed = true;
            // expect(createRequestTruck.insurance?.expiration, fact.insurance?.expiration);
          },
        );
        expect(true, passed, reason: 'The action wasn\'t resolved');
      },
    );

    test(
      "Create from pointers",
      () async {
        List<Truck> overwritedMockList = <Truck>[];
        //New truck model that use the pointers to assign data.
        for (Truck truck in mockList) {
          Truck tempMock = Truck(0, truck.vin, 1, truck.motor, null, null, 1, null, null, truck.sctNavigation, truck.maintenanceNavigation, null, truck.insuranceNavigation, truck.plates);
          for (CSMSetValidationResult validation in tempMock.evaluate()) {
            print(validation.reason);
          }
          overwritedMockList.add(tempMock);
        }

        MainResolver<MigrationTransactionResult<Truck>> fact = await service.create(overwritedMockList, auth);
        bool passed = false;
        fact.resolve(
          decoder: MigrationTransactionResultDecoder<Truck>(TruckDecoder()),
          onConnectionFailure: () {
            throw 'ConnectionFailure';
          },
          onFailure: (FailureFrame failure, int status) {
            assert(false, 'server returned a success $status');
          },
          onException: (Object exception, StackTrace trace) {
            assert(false, 'server returned a success');
          },
          onSuccess: (SuccessFrame<MigrationTransactionResult<Truck>> success) {
            passed = true;
          },
        );
        expect(passed, true, reason: 'expected the service returned a success');
      },
    );

    test(
      "Create without optional fields",
      () async {
        List<Truck> overwritedMockList = <Truck>[];
        //New truck model that use the pointers to assign data.
        for (Truck truck in mockList) {
          Truck tempMock = Truck(0, truck.vin, 0, truck.motor, null, null, null, null, truck.manufacturerNavigation, null, null, null, null, truck.plates);
          for (CSMSetValidationResult validation in tempMock.evaluate()) {
            print(validation.reason);
          }
          overwritedMockList.add(tempMock);
        }
        //New truck model that use the pointers to assign data.

        MainResolver<MigrationTransactionResult<Truck>> fact = await service.create(overwritedMockList, auth);
        bool passed = false;
        fact.resolve(
          decoder: MigrationTransactionResultDecoder<Truck>(TruckDecoder()),
          onConnectionFailure: () {
            throw 'ConnectionFailure';
          },
          onFailure: (FailureFrame failure, int status) {
            assert(false, 'server returned a success $status');
          },
          onException: (Object exception, StackTrace trace) {
            assert(false, 'server returned a success');
          },
          onSuccess: (SuccessFrame<MigrationTransactionResult<Truck>> success) {
            passed = true;
          },
        );
        expect(passed, true, reason: 'expected the service returned a success');
      },
    );
  }, timeout: Timeout.factor(5));
}
