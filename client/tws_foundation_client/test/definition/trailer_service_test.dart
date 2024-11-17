import 'dart:convert';

import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  late TrailersServiceBase service;

  late SetViewOut<Trailer> viewMock;
  late SetBatchOut<Trailer> createMock;
  late RecordUpdateOut<Trailer> updateMock;
  
  late SetViewOptions<Trailer> options;
  late List<Trailer> trailers;

  setUp(
    () {
      List<SetViewOrderOptions> noOrderigns = <SetViewOrderOptions>[];
      options = SetViewOptions<Trailer>(false, 10, 1, null, noOrderigns, <SetViewFilterNodeInterface<Trailer>>[]);
      viewMock = SetViewOut<Trailer>(<Trailer>[], 1, DateTime.now(), 3, 0, 20);
      createMock = SetBatchOut<Trailer>(<Trailer>[], <SetOperationFailure<Trailer>>[], 0, 0, 0, false);
      updateMock = RecordUpdateOut<Trailer>(Trailer.a(), Trailer.a());
      trailers = <Trailer>[
        Trailer.a(),
      ];
      Client mockClient = MockClient(
        (Request request) async {
          JObject jObject = switch (request.url.pathSegments.last) {
            'view' => SuccessFrame<SetViewOut<Trailer>>('qTracer', viewMock).encode(),
            'create' => SuccessFrame<SetBatchOut<Trailer>>('qTracer', createMock).encode(),
            'update' => SuccessFrame<RecordUpdateOut<Trailer>>('qTracer', updateMock).encode(),
            _ => <String, dynamic>{},
          };

          String object = jsonEncode(jObject);
          return Response(object, 200);
        },
      );
      service = TWSFoundationSource(
        true,
        client: mockClient,
      ).trailers;
    },
  );

  test(
    'View',
    () async {
      MainResolver<SetViewOut<Trailer>> fact = await service.view(options, '');

      bool passed = false;
      fact.resolve(
        decoder: (JObject json) => SetViewOut<Trailer>.des(json, Trailer.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          assert(false, 'server returned a success $status');
        },
        onException: (Object exception, StackTrace trace) {
          assert(false, 'server returned a success');
        },
        onSuccess: (SuccessFrame<SetViewOut<Trailer>> success) {
          passed = true;

          SetViewOut<Trailer> fact = success.estela;
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
      MainResolver<SetBatchOut<Trailer>> fact = await service.create(trailers, '');
      bool pased = false;
      fact.resolve(
        decoder: (JObject json) => SetBatchOut<Trailer>.des(json, Trailer.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          throw failure;
        },
        onSuccess: (SuccessFrame<SetBatchOut<Trailer>> success) {
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
      MainResolver<RecordUpdateOut<Trailer>> fact = await service.update(Trailer.a(), '');
      bool pased = false;
      fact.resolve(
        decoder: (JObject json) => RecordUpdateOut<Trailer>.des(json, Trailer.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          throw failure;
        },
        onSuccess: (SuccessFrame<RecordUpdateOut<Trailer>> success) {
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
