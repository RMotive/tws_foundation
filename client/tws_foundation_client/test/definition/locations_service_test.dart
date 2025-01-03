import 'dart:convert';

import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  late LocationsServiceBase service;
  late SetViewOut<Location> viewMock;
  late SetBatchOut<Location> createMock;
  late RecordUpdateOut<Location> updateMock;
  late SetViewOptions<Location> options;
  late List<Location> locations;
  setUp(
    () {
      List<SetViewOrderOptions> noOrderigns = <SetViewOrderOptions>[];
      options = SetViewOptions<Location>(false, 10, 1, null, noOrderigns, <SetViewFilterNodeInterface<Location>>[]);
      viewMock = SetViewOut<Location>(<Location>[], 1, DateTime.now(), 3, 0, 20);
      createMock = SetBatchOut<Location>(<Location>[], <SetOperationFailure<Location>>[], 0, 0, 0, false);
      updateMock = RecordUpdateOut<Location>(Location.a(), Location.a());
      locations = <Location>[
        Location.a(),
      ];
      Client mockClient = MockClient(
        (Request request) async {
          JObject jObject = switch (request.url.pathSegments.last) {
            'view' => SuccessFrame<SetViewOut<Location>>('qTracer', viewMock).encode(),
            'create' => SuccessFrame<SetBatchOut<Location>>('qTracer', createMock).encode(),
            'update' => SuccessFrame<RecordUpdateOut<Location>>('qTracer', updateMock).encode(),
            _ => <String, dynamic>{},
          };

          String object = jsonEncode(jObject);
          return Response(object, 200);
        },
      );
      service = TWSFoundationSource(
        true,
        client: mockClient,
      ).locations;
    },
  );

  test(
    'View',
    () async {
      MainResolver<SetViewOut<Location>> fact = await service.view(options, '');

      bool passed = false;
      fact.resolve(
        decoder: (JObject json) => SetViewOut<Location>.des(json, Location.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          assert(false, 'server returned a success $status');
        },
        onException: (Object exception, StackTrace trace) {
          assert(false, 'server returned a success');
        },
        onSuccess: (SuccessFrame<SetViewOut<Location>> success) {
          passed = true;

          SetViewOut<Location> fact = success.estela;
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
      MainResolver<SetBatchOut<Location>> fact = await service.create(locations, '');
      bool pased = false;
      fact.resolve(
        decoder: (JObject json) => SetBatchOut<Location>.des(json, Location.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          throw failure;
        },
        onSuccess: (SuccessFrame<SetBatchOut<Location>> success) {
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
      MainResolver<RecordUpdateOut<Location>> fact = await service.update(Location.a(), '');
      bool pased = false;
      fact.resolve(
        decoder: (JObject json) => RecordUpdateOut<Location>.des(json, Location.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          throw failure;
        },
        onSuccess: (SuccessFrame<RecordUpdateOut<Location>> success) {
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
