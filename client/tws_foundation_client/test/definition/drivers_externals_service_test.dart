import 'dart:convert';

import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  late DriversExternalsServiceBase service;
  late SetViewOut<DriverExternal> viewMock;
  late DriverExternal createMock;
  late SetViewOptions<DriverExternal> options;

  setUp(
    () {
      List<SetViewOrderOptions> noOrderigns = <SetViewOrderOptions>[];
      options = SetViewOptions<DriverExternal>(false, 10, 1, null, noOrderigns, <SetViewFilterNodeInterface<DriverExternal>>[]);
      viewMock = SetViewOut<DriverExternal>(<DriverExternal>[], 1, DateTime.now(), 3, 0, 20);
      createMock = DriverExternal(0, 1, 1, 1, null, null, null);

      Client mockClient = MockClient(
        (Request request) async {
          JObject jObject = switch (request.url.pathSegments.last) {
            'view' => SuccessFrame<SetViewOut<DriverExternal>>('qTracer', viewMock).encode(),
            'create' => SuccessFrame<DriverExternal>('qTracer', createMock).encode(),
            _ => <String, dynamic>{},
          };

          String object = jsonEncode(jObject);
          return Response(object, 200);
        },
      );
      service = TWSFoundationSource(
        true,
        client: mockClient,
      ).driversExternals;
    },
  );

  test(
    'View',
    () async {
      MainResolver<SetViewOut<DriverExternal>> fact = await service.view(options, '');

      bool passed = false;
      fact.resolve(
        decoder: SetViewOutDecode<DriverExternal>(DriverExternalDecoder()),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          assert(false, 'server returned a success $status');
        },
        onException: (Object exception, StackTrace trace) {
          assert(false, 'server returned a success');
        },
        onSuccess: (SuccessFrame<SetViewOut<DriverExternal>> success) {
          passed = true;

          SetViewOut<DriverExternal> fact = success.estela;
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
