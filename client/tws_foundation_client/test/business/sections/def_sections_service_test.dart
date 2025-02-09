import 'dart:convert';

import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  late SectionsServiceBase service;
  late SetViewOut<Section> viewMock;
  late SetViewOptions<Section> options;

  setUp(
    () {
      List<SetViewOrderOptions> noOrderigns = <SetViewOrderOptions>[];
      options = SetViewOptions<Section>(false, 10, 1, null, noOrderigns, <SetViewFilterNodeInterface<Section>>[]);
      viewMock = SetViewOut<Section>(<Section>[], 1, DateTime.now(), 3, 0, 20);

      Client mockClient = MockClient(
        (Request request) async {
          JObject jObject = switch (request.url.pathSegments.last) {
            'view' => SuccessFrame<SetViewOut<Section>>('qTracer', viewMock).encode(),
            _ => <String, dynamic>{},
          };

          String object = jsonEncode(jObject);
          return Response(object, 200);
        },
      );
      service = TWSFoundationSource(
        true,
        client: mockClient,
      ).sections;
    },
  );

  test(
    'View',
    () async {
      MainResolver<SetViewOut<Section>> fact = await service.view(options, '');

      bool passed = false;
      fact.resolve(
        decoder: (JObject json) => SetViewOut<Section>.des(json, Section.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          assert(false, 'server returned a success $status');
        },
        onException: (Object exception, StackTrace trace) {
          assert(false, 'server returned a success');
        },
        onSuccess: (SuccessFrame<SetViewOut<Section>> success) {
          passed = true;

          SetViewOut<Section> fact = success.estela;
          expect(viewMock.page, fact.page);
          expect(viewMock.pages, fact.pages);
          expect(viewMock.length, fact.length);
          expect(viewMock.creation, fact.creation);
        },
      );

      expect(passed, true, reason: 'expected the service returned a success');
    },
    timeout: Timeout.factor(5),
  );
}
