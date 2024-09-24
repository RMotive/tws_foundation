import 'dart:convert';

import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  late TrailersExternalsServiceBase service;
  late SetViewOut<TrailerExternal> viewMock;
  late TrailerExternal createMock;
  late SetViewOptions<TrailerExternal> options;

  setUp(
    () {
      List<SetViewOrderOptions> noOrderigns = <SetViewOrderOptions>[];
      options = SetViewOptions<TrailerExternal>(false, 10, 1, null, noOrderigns, <SetViewFilterNodeInterface<TrailerExternal>>[]);
      viewMock = SetViewOut<TrailerExternal>(<TrailerExternal>[], 1, DateTime.now(), 3, 0, 20);
      createMock = TrailerExternal(0, 1, 1,"Carrier test", "12345678", "87654321",null, null);

      Client mockClient = MockClient(
        (Request request) async {
          JObject jObject = switch (request.url.pathSegments.last) {
            'view' => SuccessFrame<SetViewOut<TrailerExternal>>('qTracer', viewMock).encode(),
            'create' => SuccessFrame<TrailerExternal>('qTracer', createMock).encode(),
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
        decoder: SetViewOutDecode<TrailerExternal>(TrailerExternalDecoder()),
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
}
