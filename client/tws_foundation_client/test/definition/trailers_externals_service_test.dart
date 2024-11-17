import 'dart:convert';

import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  late TrailersExternalsServiceBase service;

  late SetViewOut<TrailerExternal> viewMock;
  late SetBatchOut<TrailerExternal> createMock;
  late RecordUpdateOut<TrailerExternal> updateMock;

  late SetViewOptions<TrailerExternal> options;
  late List<TrailerExternal> trailers;

  setUp(
    () {
      List<SetViewOrderOptions> noOrderigns = <SetViewOrderOptions>[];
      options = SetViewOptions<TrailerExternal>(false, 10, 1, null, noOrderigns, <SetViewFilterNodeInterface<TrailerExternal>>[]);
      viewMock = SetViewOut<TrailerExternal>(<TrailerExternal>[], 1, DateTime.now(), 3, 0, 20);
      createMock = SetBatchOut<TrailerExternal>(<TrailerExternal>[], <SetOperationFailure<TrailerExternal>>[], 0, 0, 0, false);
      updateMock = RecordUpdateOut<TrailerExternal>(TrailerExternal.a(), TrailerExternal.a());
      trailers = <TrailerExternal>[
        TrailerExternal.a(),
      ];

      Client mockClient = MockClient(
        (Request request) async {
          JObject jObject = switch (request.url.pathSegments.last) {
            'view' => SuccessFrame<SetViewOut<TrailerExternal>>('qTracer', viewMock).encode(),
            'create' => SuccessFrame<SetBatchOut<TrailerExternal>>('qTracer', createMock).encode(),
            'update' => SuccessFrame<RecordUpdateOut<TrailerExternal>>('qTracer', updateMock).encode(),
            _ => <String, dynamic>{},
          };

          String object = jsonEncode(jObject);
          return Response(object, 200);
        },
      );
      service = TWSFoundationSource(
        true,
        client: mockClient,
      ).trailersExternals;
    },
  );

  test(
    'View',
    () async {
      MainResolver<SetViewOut<TrailerExternal>> fact = await service.view(options, '');

      bool passed = false;
      fact.resolve(
        decoder: (JObject json) => SetViewOut<TrailerExternal>.des(json, TrailerExternal.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          assert(false, 'server returned a success $status');
        },
        onException: (Object exception, StackTrace trace) {
          assert(false, 'server returned a success');
        },
        onSuccess: (SuccessFrame<SetViewOut<TrailerExternal>> success) {
          passed = true;

          SetViewOut<TrailerExternal> fact = success.estela;
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
      MainResolver<SetBatchOut<TrailerExternal>> fact = await service.create(trailers, '');
      bool pased = false;
      fact.resolve(
        decoder: (JObject json) => SetBatchOut<TrailerExternal>.des(json, TrailerExternal.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          throw failure;
        },
        onSuccess: (SuccessFrame<SetBatchOut<TrailerExternal>> success) {
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
      MainResolver<RecordUpdateOut<TrailerExternal>> fact = await service.update(TrailerExternal.a(), '');
      bool pased = false;
      fact.resolve(
        decoder: (JObject json) => RecordUpdateOut<TrailerExternal>.des(json, TrailerExternal.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          throw failure;
        },
        onSuccess: (SuccessFrame<RecordUpdateOut<TrailerExternal>> success) {
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
