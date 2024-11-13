import 'dart:convert';

import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/src/services/business/bases/trailers_classes_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  late TrailersClassesServiceBase service;
  late SetViewOut<TrailerClass> viewMock;
  late SetViewOptions<TrailerClass> options;

  setUp(
    () {
      List<SetViewOrderOptions> noOrderigns = <SetViewOrderOptions>[];
      options = SetViewOptions<TrailerClass>(false, 10, 1, null, noOrderigns, <SetViewFilterNodeInterface<TrailerClass>>[]);
      viewMock = SetViewOut<TrailerClass>(<TrailerClass>[], 1, DateTime.now(), 3, 0, 20);

      Client mockClient = MockClient(
        (Request request) async {
          JObject jObject = switch (request.url.pathSegments.last) {
            'view' => SuccessFrame<SetViewOut<TrailerClass>>('qTracer', viewMock).encode(),
            _ => <String, dynamic>{},
          };

          String object = jsonEncode(jObject);
          return Response(object, 200);
        },
      );
      service = TWSFoundationSource(
        true,
        client: mockClient,
      ).trailersClasses;
    },
  );

  test(
    'View',
    () async {
      MainResolver<SetViewOut<TrailerClass>> fact = await service.view(options, '');

      bool passed = false;
      fact.resolve(
        decoder: (JObject json) => SetViewOut<TrailerClass>.des(json, TrailerClass.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          assert(false, 'server returned a success $status');
        },
        onException: (Object exception, StackTrace trace) {
          assert(false, 'server returned a success');
        },
        onSuccess: (SuccessFrame<SetViewOut<TrailerClass>> success) {
          passed = true;

          SetViewOut<TrailerClass> fact = success.estela;
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
}
