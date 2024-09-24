import 'dart:math';

import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../integration_credentials.dart';

void main() {
  late String auth;
  late TrucksServiceBase service;
  late List<Truck> mocks;

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
        int rnd = Random().nextInt(900) + 99;
        String randomToken = '${i}_qual$rnd';
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
        TruckCommon truckCommon = TruckCommon(
          0, //id
          1, //status
          "ECO$randomToken", //economic
          1, //location
          1, //situation
          null,
          null, //statusNavigation
        );
        Truck truck = Truck(
            0, // id
            1, //Status
            2, //manufacturer
            0, //common
            1, //carrier
            "Motor $randomToken", //motor
            "VINtest-$randomToken", //vin
            1, //maintenance
            1, //insurance
            null, //statusNavigation
            null, //manufacturerNavigation
            truckCommon, //truckCommonNavigation
            null, //maintenanceNavigation
            null, //insuranceNavigation
            null,
            <Plate>[plateMX, plateUSA]);
        mocks.add(truck);
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
        decoder: SetViewOutDecode<Truck>(TruckDecoder()),
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
}
