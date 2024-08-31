import 'dart:convert';

import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  late SituationsServiceBase service;
  late MigrationView<Situation> viewMock;
  late Situation createMock;
  late MigrationViewOptions options;

  setUp(
    () {
      List<MigrationViewOrderOptions> noOrderigns = <MigrationViewOrderOptions>[];
      options = MigrationViewOptions(null, noOrderigns, 1, 10, false);
      viewMock = MigrationView<Situation>(<Situation>[], 1, DateTime.now(), 3, 0, 20);

      createMock = Situation(0, "Situational test", "Description test ");

      Client mockClient = MockClient(
        (Request request) async {
         JObject jObject = switch (request.url.pathSegments.last) {
            'view' => SuccessFrame<MigrationView<Situation>>('qTracer', viewMock).encode(),
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
      MainResolver<MigrationView<Situation>> fact = await service.view(options, '');

      bool passed = false;
      fact.resolve(
        decoder: MigrationViewDecode<Situation>(SituationDecoder()),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          assert(false, 'server returned a success $status');
        },
        onException: (Object exception, StackTrace trace) {
          assert(false, 'server returned a success');
        },
        onSuccess: (SuccessFrame<MigrationView<Situation>> success) {
          passed = true;

          MigrationView<Situation> fact = success.estela;
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
