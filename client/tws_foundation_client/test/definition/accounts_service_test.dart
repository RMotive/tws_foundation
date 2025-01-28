import 'dart:convert';

import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  late AccountsServiceBase service;
  late SetViewOut<Account> viewMock;
  late SetViewOptions<Account> options;
  late SetBatchOut<Account> createMock;
  late RecordUpdateOut<Account> updateMock;  
  late List<Account> accounts;

  setUp(
    () {
      List<SetViewOrderOptions> noOrderigns = <SetViewOrderOptions>[];
      options = SetViewOptions<Account>(false, 10, 1, null, noOrderigns, <SetViewFilterNodeInterface<Account>>[]);
      viewMock = SetViewOut<Account>(<Account>[], 1, DateTime.now(), 3, 0, 20);
      createMock = SetBatchOut<Account>(<Account>[], <SetOperationFailure<Account>>[], 0, 0, 0, false);
      updateMock = RecordUpdateOut<Account>(Account.a(), Account.a());
      accounts = <Account>[
        Account.a(),
      ];
      Client mockClient = MockClient(
        (Request request) async {
          JObject jObject = switch (request.url.pathSegments.last) {
            'view' => SuccessFrame<SetViewOut<Account>>('qTracer', viewMock).encode(),
            'create' => SuccessFrame<SetBatchOut<Account>>('qTracer', createMock).encode(),
            'update' => SuccessFrame<RecordUpdateOut<Account>>('qTracer', updateMock).encode(),
            _ => <String, dynamic>{},
          };

          String object = jsonEncode(jObject);
          return Response(object, 200);
        },
      );
      service = TWSFoundationSource(
        true,
        client: mockClient,
      ).accounts;
    },
  );

  test(
    'View',
    () async {
      MainResolver<SetViewOut<Account>> fact = await service.view(options, '');

      bool passed = false;
      fact.resolve(
        decoder: (JObject json) => SetViewOut<Account>.des(json, Account.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          assert(false, 'server returned a success $status');
        },
        onException: (Object exception, StackTrace trace) {
          assert(false, 'server returned a success');
        },
        onSuccess: (SuccessFrame<SetViewOut<Account>> success) {
          passed = true;

          SetViewOut<Account> fact = success.estela;
          expect(viewMock.page, fact.page);
          expect(viewMock.pages, fact.pages);
          expect(viewMock.records, fact.records);
          expect(viewMock.creation, fact.creation);
        },
      );

      expect(passed, true, reason: 'expected the service returned a success');
    },
    timeout: Timeout.factor(5),
  );
  test(
    'Create',
    () async {
      MainResolver<SetBatchOut<Account>> fact = await service.create(accounts, '');
      bool pased = false;
      fact.resolve(
        decoder: (JObject json) => SetBatchOut<Account>.des(json, Account.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          throw failure;
        },
        onSuccess: (SuccessFrame<SetBatchOut<Account>> success) {
          pased = true;
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
      );
      expect(pased, true);
    },
  );

  test(
    'Update',
    () async {
      MainResolver<RecordUpdateOut<Account>> fact = await service.update(Account.a(), '');
      bool pased = false;
      fact.resolve(
        decoder: (JObject json) => RecordUpdateOut<Account>.des(json, Account.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          throw failure;
        },
        onSuccess: (SuccessFrame<RecordUpdateOut<Account>> success) {
          pased = true;
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
      );
      expect(pased, true);
    },
  );
}
