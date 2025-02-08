import 'dart:convert';
import 'dart:math';
import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../integration_credentials.dart';
void main() {
  late String auth;
  late AccountsServiceBase service;
  late List<Account> mocks;
  
  final int validPermit = 58;
  final int updatedValidPermit = 69;
  final int validAccount = 14;


  Account buildMock(String randomToken){
    return Account(
      0,
      0,
      "user $randomToken",
      base64Encode(utf8.encode(randomToken)),
      false,
      Contact(
        0,
        "name $randomToken",
        "fatherlastname $randomToken",
        "email@$randomToken",
        "664$randomToken",
      ),
      <AccountPermit>[
        AccountPermit(
          0,
          validPermit, 
          null,
          null,
        )
      ],
      <AccountProfile>[
        AccountProfile(
          0,
          0, 
          null, 
          Profile(
            0,
            'client test profile $randomToken',
            null,
          ),
        ),
      ]
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
      mocks = <Account>[];
      for (int i = 0; i < 3; i++) {
        int rnd = Random().nextInt(900)  + 99;
        String randomToken = '${i}_qual$rnd';
        Account mock = buildMock(randomToken);
        mocks.add(mock);
      }

      service = source.accounts;
    },
  );

  test(
    'View',
    () async {
      MainResolver<SetViewOut<Account>> fact = await service.view(
        SetViewOptions<Account>(false, 10, 1, null, <SetViewOrderOptions>[], <SetViewFilterNodeInterface<Account>>[]),
        auth,
      );
      fact.resolve(
        decoder: (JObject json) => SetViewOut<Account>.des(json, Account.des),
        onConnectionFailure: () {
          throw 'ConnectionFailure';
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
        onFailure: (FailureFrame failure, int status) {
          throw failure.estela.system;
        },
        onSuccess: (SuccessFrame<SetViewOut<Account>> success) {
          SetViewOut<Account> fact = success.estela;

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
      MainResolver<SetBatchOut<Account>> fact = await service.create(mocks, auth);
      bool resolved = false;
      fact.resolve(
        decoder: (JObject json) => SetBatchOut<Account>.des(json, Account.des),
        onException: (Object exception, StackTrace trace) => throw exception,
        onConnectionFailure: () => throw Exception('Connection failure'),
        onFailure: (FailureFrame failure, int status) => throw Exception(failure.estela.advise),
        onSuccess: (SuccessFrame<SetBatchOut<Account>> success) {
          resolved = true;
        },
      );

      expect(true, resolved, reason: 'The action wasn\'t resolved');
    },
  );

  group(
    'Update',
    () {
      late Account creationMock;
      test(
        'Creates when unexist',
        () async {
          int rnd = Random().nextInt(900)  + 99;
          Account mock = buildMock("$rnd");

          MainResolver<RecordUpdateOut<Account>> fact = await service.update(mock, auth);
          RecordUpdateOut<Account> actEffect = await fact.act((JObject json) =>  RecordUpdateOut<Account>.des(json, Account.des));
          assert(actEffect.previous == null);
          assert(actEffect.updated.id > 0);

          creationMock = actEffect.updated;
        },
      );

      test(
        'Updates when exist',
        () async {
          int rnd = Random().nextInt(900)  + 99;
          creationMock.user = 'UPDT_USER$rnd';
          creationMock.contactNavigation!.name = 'UPDT_name_$rnd';
          creationMock.accountPermits = <AccountPermit>[
            AccountPermit(
              creationMock.id,
              69,
              null,
              null,
            ),
          ];
          MainResolver<RecordUpdateOut<Account>> fact = await service.update(creationMock, auth);
          RecordUpdateOut<Account> actEffect = await fact.act((JObject json) =>  RecordUpdateOut<Account>.des(json ,Account.des));
          assert(actEffect.previous != null);
          assert(actEffect.updated.id == creationMock.id);
          assert(actEffect.updated.user != actEffect.previous!.user);
          assert(actEffect.updated.contactNavigation!.name != actEffect.previous!.contactNavigation!.name);
          assert(actEffect.updated.accountPermits.length == 1 && actEffect.updated.accountPermits.first.permit == updatedValidPermit && actEffect.previous!.accountPermits.first.permit == validPermit);
          assert(actEffect.updated.accountProfiles.length == 1 && actEffect.updated.accountProfiles.first.profile == actEffect.previous!.accountProfiles.first.profile);
        },
      );
    },
  );

  test(
    'GetPermits',
    () async {
      MainResolver<SetViewOut<Permit>> fact = await service.getPermits(
        Account.a().clone(id: validAccount),
        auth,
      );
      fact.resolve(
        decoder: (JObject json) => SetViewOut<Permit>.des(json, Permit.des),
        onConnectionFailure: () {
          throw 'ConnectionFailure';
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
        onFailure: (FailureFrame failure, int status) {
          throw failure.estela.system;
        },
        onSuccess: (SuccessFrame<SetViewOut<Permit>> success) {
          SetViewOut<Permit> fact = success.estela;

          expect(fact.records >= 0, true);
        },
      );
    },
  );
}
