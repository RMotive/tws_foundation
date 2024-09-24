import 'dart:convert';

import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  late SituationsServiceBase service;
  late SetViewOut<Situation> viewMock;
  late Situation createMock;
  late SetViewOptions<Situation> options;

  setUp(
    () {
      List<SetViewOrderOptions> noOrderigns = <SetViewOrderOptions>[];
      options = SetViewOptions<Situation>(false, 10, 1, null, noOrderigns, <SetViewFilterNodeInterface<Situation>>[]);
      viewMock = SetViewOut<Situation>(<Situation>[], 1, DateTime.now(), 3, 0, 20);

      createMock = Situation(0, "Situational test", "Description test ");

      Client mockClient = MockClient(
        (Request request) async {
         JObject jObject = switch (request.url.pathSegments.last) {
            'view' => SuccessFrame<SetViewOut<Situation>>('qTracer', viewMock).encode(),
            'create' => SuccessFrame<Situation>('qTracer', createMock).encode(),
            _ => <String, dynamic>{},
          };
          
          String object = jsonEncode(jObject);
          return Response(object, 200);
        },
      );

      service = TWSFoundationSource(
        true,
        client: mockClient,
      ).situations;
    },
  );

  test(
    'View',
    () async {
      MainResolver<SetViewOut<Situation>> fact = await service.view(options, '');

      bool passed = false;
      fact.resolve(
        decoder: SetViewOutDecode<Situation>(SituationDecoder()),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          assert(false, 'server returned a success $status');
        },
        onException: (Object exception, StackTrace trace) {
          assert(false, 'server returned a success');
        },
        onSuccess: (SuccessFrame<SetViewOut<Situation>> success) {
          passed = true;

          SetViewOut<Situation> fact = success.estela;
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
