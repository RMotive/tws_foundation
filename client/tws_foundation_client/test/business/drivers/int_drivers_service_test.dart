import 'dart:math';

import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../../integration_credentials.dart';

void main() {
  late String auth;
  late DriversServiceBase service;
  late List<Driver> mocks;

  Driver buildMock(String randomToken) {
    DateTime time = DateTime.now();
    Driver mock = Driver(
      0, 
      1, 
      0, 
      0, 
      "driver_$randomToken", 
      time, 
      time, 
      time, 
      "twi$randomToken", 
      time, 
      "vis$randomToken", 
      time, 
      "fast_$randomToken", 
      time, 
      "anam_number_t: $randomToken", 
      time, 
      DriverCommon(
        0, 
        1, 
        "lic$randomToken", 
        null, 
        null,
        null,
      ), 
      Employee(
        0, // id 
        1, // status
        0, // identification
        null, // address 
        null, // approach
        "curp_test$randomToken", // curp
        time, // antecedentesNoPenalesExp
        "rfc$randomToken", // RFC
        "ns$randomToken", // NSS
        time, // ImssRegistrationDate 
        time, // hiringDate
        time, // TerminationDate
        Identification(
          0, 
          1, 
          "name_testing_$randomToken", 
          "fatherlastname_testing_$randomToken", 
          "motherlastname_testing_$randomToken", 
          time, 
          null,
        ), // IdentificationNavigation
        null, // StatusNavigation
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
      ), 
      null
    );
    return mock;
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

      service = source.drivers;
    },
  );

  test(
    'View',
    () async {
      MainResolver<SetViewOut<Driver>> fact = await service.view(
        SetViewOptions<Driver>(false, 10, 1, null, <SetViewOrderOptions>[], <SetViewFilterNodeInterface<Driver>>[]),
        auth,
      );
      fact.resolve(
        decoder: (JObject json) => SetViewOut<Driver>.des(json, Driver.des),
        onConnectionFailure: () {
          throw 'ConnectionFailure';
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
        onFailure: (FailureFrame failure, int status) {
          throw failure.estela.system;
        },
        onSuccess: (SuccessFrame<SetViewOut<Driver>> success) {
          SetViewOut<Driver> fact = success.estela;

          expect(fact.count >= fact.length, true);
          expect(fact.length >= 0, true);
          expect(fact.page, 1);
          expect(fact.pages >= fact.page, true);
          expect(fact.records.length, fact.length);
        },
      );

      mocks = <Driver>[];
      for (int i = 0; i < 3; i++) {
        int rnd = Random().nextInt(900)  + 99;
        String randomToken = '${i}_qual$rnd';
        Driver mock = buildMock(randomToken);
        mocks.add(mock);
      }
    },
  );

  test(
    'Create',
    () async {
      MainResolver<SetBatchOut<Driver>> fact = await service.create(mocks, auth);
      bool resolved = false;
      fact.resolve(
        decoder: (JObject json) => SetBatchOut<Driver>.des(json, Driver.des),
        onException: (Object exception, StackTrace trace) => throw exception,
        onConnectionFailure: () => throw Exception('Connection failure'),
        onFailure: (FailureFrame failure, int status) => throw Exception(failure.estela.advise),
        onSuccess: (SuccessFrame<SetBatchOut<Driver>> success) {
          resolved = true;
        },
      );

      expect(true, resolved, reason: 'The action wasn\'t resolved');
    },
  );

  group(
    'Update',
    () {
      late Driver creationMock;
      test(
        'Creates when unexist',
        () async {
          int rnd = Random().nextInt(900)  + 99;
          Driver mock = buildMock("U_qual$rnd");

          MainResolver<RecordUpdateOut<Driver>> fact = await service.update(mock, auth);
          RecordUpdateOut<Driver> actEffect = await fact.act((JObject json) =>  RecordUpdateOut<Driver>.des(json, Driver.des));
          assert(actEffect.previous == null);
          assert(actEffect.updated.id > 0);

          creationMock = actEffect.updated;
        },
      );

      test(
        'Updates when exist',
        () async {
          int rnd = Random().nextInt(900)  + 99;
          creationMock.visa = 'UPDT_VISA$rnd';
          creationMock.driverCommonNavigation!.license = 'UPDT_lic_$rnd';
          creationMock.employeeNavigation!.identificationNavigation!.name = 'UPDT_name_$rnd';
          MainResolver<RecordUpdateOut<Driver>> fact = await service.update(creationMock, auth);
          RecordUpdateOut<Driver> actEffect = await fact.act((JObject json) =>  RecordUpdateOut<Driver>.des(json ,Driver.des));
          assert(actEffect.previous != null);
          assert(actEffect.updated.id == creationMock.id);
          assert(actEffect.updated.visa != actEffect.previous!.visa);
          assert(actEffect.updated.driverCommonNavigation!.license != actEffect.previous!.driverCommonNavigation!.license);
          assert(actEffect.updated.employeeNavigation!.identificationNavigation!.name != actEffect.previous!.employeeNavigation!.identificationNavigation!.name);

        },
      );
    },
  );
  test(
    'Delete',
    () async {
      List<Driver>  deleteMocks = <Driver>[];
      int rnd = Random().nextInt(900)  + 99;
      String randomToken = 'D_qual$rnd';
      deleteMocks.add(buildMock(randomToken));
      late Driver newMock;

      MainResolver<SetBatchOut<Driver>> fact = await service.create(deleteMocks, auth);
      bool resolved = false;
      fact.resolve(
        decoder: (JObject json) => SetBatchOut<Driver>.des(json, Driver.des),
        onException: (Object exception, StackTrace trace) => throw exception,
        onConnectionFailure: () => throw Exception('Connection failure'),
        onFailure: (FailureFrame failure, int status) => throw Exception(failure.estela.advise),
        onSuccess: (SuccessFrame<SetBatchOut<Driver>> success) {
          resolved = true;
          expect(success.estela.failures.isEmpty, true, reason: 'Mock creation failure');
          newMock = success.estela.successes.first;
        },
      );
      expect(true, resolved, reason: 'The action wasn\'t resolved');
      resolved = false;

      MainResolver<Driver> deleteFact = await service.delete(
        newMock,
        auth,
      );
      deleteFact.resolve(
        decoder: (JObject json) => Driver.des(json),
        onConnectionFailure: () {
          throw 'ConnectionFailure';
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
        onFailure: (FailureFrame failure, int status) {
          throw failure.estela.system;
        },
        onSuccess: (SuccessFrame<Driver> success) {
          resolved = true;
        },
      );
      expect(true, resolved, reason: 'The action wasn\'t resolved');

    },
  );
}
