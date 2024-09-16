import 'dart:convert';

import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  late ManufacturersServiceBase service;
  late SetViewOut<Manufacturer> viewMock;
  late Manufacturer createMock;
  late SetViewOptions options;

  setUp(
    () {
      List<SetViewOrderOptions> noOrderigns = <SetViewOrderOptions>[];
      options = SetViewOptions(null, noOrderigns, 1, 10, false);
      viewMock = SetViewOut<Manufacturer>(<Manufacturer>[], 1, DateTime.now(), 3, 0, 20);

      DateTime time = DateTime.now();
      createMock = Manufacturer(0, "S23", "SCANIA", time, <Truck>[]);

      Client mockClient = MockClient(
        (Request request) async {
          JObject jObject = switch (request.url.pathSegments.last) {
            'view' => SuccessFrame<SetViewOut<Manufacturer>>('qTracer', viewMock).encode(),
            'create' => SuccessFrame<Manufacturer>('qTracer', createMock).encode(),
            _ => <String, dynamic>{},
          };

          String object = jsonEncode(jObject);
          return Response(object, 200);
        },
      );
      service = TWSFoundationSource(
        true,
        client: mockClient,
      ).manufacturers;
    },
  );

  test(
    'View',
    () async {
      MainResolver<SetViewOut<Manufacturer>> fact = await service.view(options, '');

      bool passed = false;
      fact.resolve(
        decoder: SetViewOutDecode<Manufacturer>(ManufacturerDecoder()),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          assert(false, 'server returned a success $status');
        },
        onException: (Object exception, StackTrace trace) {
          assert(false, 'server returned a success');
        },
        onSuccess: (SuccessFrame<SetViewOut<Manufacturer>> success) {
          passed = true;

          SetViewOut<Manufacturer> fact = success.estela;
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
