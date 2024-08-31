
import 'dart:math';

import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../integration_credentials.dart';

void main() {
  late String auth;
  late SolutionsServiceBase service;

  late List<Solution> mocks;

  setUp(
    () async {
      final TWSAdministrationSource source = TWSAdministrationSource(
        false,
        headers: <String, String>{
          'CSMDisposition': 'Quality',
        },
      );


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

      service = source.solutions;
      mocks = <Solution>[];
      for (int i = 0; i < 3; i++) {
        String randomToken = '${i}_quality';

        mocks.add(Solution(0, randomToken, 'QLTY$i', null));
      }
    },
  );

  test(
    'View',
    () async {

      MainResolver<MigrationView<Solution>> fact = await service.view(
        MigrationViewOptions(null, <MigrationViewOrderOptions>[], 1, 10, false),
        auth,
      );
      fact.resolve(
        decoder: MigrationViewDecode<Solution>(SolutionDecoder()),
        onConnectionFailure: () {
          throw 'ConnectionFailure';
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
        onFailure: (FailureFrame failure, int status) {
          throw failure.estela.system;
        },
        onSuccess: (SuccessFrame<MigrationView<Solution>> success) {
          MigrationView<Solution> fact = success.estela;

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
      MainResolver<MigrationTransactionResult<Solution>> fact = await service.create(mocks, auth);

      bool resolved = false;
      fact.resolve(
        decoder: MigrationTransactionResultDecoder<Solution>(SolutionDecoder()),
        onException: (Object exception, StackTrace trace) => throw exception,
        onConnectionFailure: () => throw Exception('Connection failure'),
        onFailure: (FailureFrame failure, int status) => throw Exception(failure.estela.advise),
        onSuccess: (SuccessFrame<MigrationTransactionResult<Solution>> success) {
          resolved = true;
        },
      );

      expect(true, resolved, reason: 'The action wasn\'t resolved');
    },
  );

  group(
    'Update',
    () {
      final MigrationUpdateResultDecoder<Solution> decoder = MigrationUpdateResultDecoder<Solution>(SolutionDecoder());
      late Solution creationMock;
      test(
        'Creates when unexist',
        () async {
          int rnd = Random().nextInt(900)  + 99;
          Solution mock = Solution.b('QualityT$rnd', 'QT$rnd');

          MainResolver<MigrationUpdateResult<Solution>> fact = await service.update(mock, auth);
          MigrationUpdateResult<Solution> actEffect = await fact.act(decoder);
          assert(actEffect.previous == null);
          assert(actEffect.updated.id > 0);

          creationMock = actEffect.updated;
        },
      );

      test(
        'Updates when exist',
        () async {
          int rnd = Random().nextInt(900)  + 99;
          Solution mock = creationMock.clone(name: 'a new name to test: $rnd');
          MainResolver<MigrationUpdateResult<Solution>> fact = await service.update(mock, auth);
          MigrationUpdateResult<Solution> actEffect = await fact.act(decoder);
          assert(actEffect.previous != null);
          assert(actEffect.updated.id == creationMock.id);
        },
      );
    },
  );
}
