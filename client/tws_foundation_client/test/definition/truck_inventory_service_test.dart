import 'dart:convert';

import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/src/services/bases/truck_inventory_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  late TrucksInventoriesServiceBase service;
  late SetViewOut<TruckInventory> viewMock;
  late SetViewOptions<TruckInventory> options;

  setUp(
    () {
      List<SetViewOrderOptions> noOrderigns = <SetViewOrderOptions>[];
      options = SetViewOptions<TruckInventory>(false, 10, 1, null, noOrderigns, <SetViewFilterNodeInterface<TruckInventory>>[]);
      viewMock = SetViewOut<TruckInventory>(<TruckInventory>[], 1, DateTime.now(), 3, 0, 20);

      Client mockClient = MockClient(
        (Request request) async {
          JObject jObject = switch (request.url.pathSegments.last) {
            'view' => SuccessFrame<SetViewOut<TruckInventory>>('qTracer', viewMock).encode(),
            _ => <String, dynamic>{},
          };

          String object = jsonEncode(jObject);
          return Response(object, 200);
        },
      );
      service = TWSFoundationSource(
        true,
        client: mockClient,
      ).trucksInventories;
    },
  );

  test(
    'View',
    () async {
      MainResolver<SetViewOut<TruckInventory>> fact = await service.view(options, '');

      bool passed = false;
      fact.resolve(
        decoder: (JObject json) => SetViewOut<TruckInventory>.des(json, TruckInventory.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          assert(false, 'server returned a success $status');
        },
        onException: (Object exception, StackTrace trace) {
          assert(false, 'server returned a success');
        },
        onSuccess: (SuccessFrame<SetViewOut<TruckInventory>> success) {
          passed = true;

          SetViewOut<TruckInventory> fact = success.estela;
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
