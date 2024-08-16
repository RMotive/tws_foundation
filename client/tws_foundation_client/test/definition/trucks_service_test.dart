import 'dart:convert';

import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  late TrucksServiceBase service;
  late MigrationView<Truck> viewMock;
  late MigrationViewOptions options;
  MigrationTransactionResult<Truck> createMock;
  List<Truck> models = <Truck>[];
  group("Truck Service - Definition Service", () {
    setUp(
      () {
        models = <Truck>[];
        List<MigrationViewOrderOptions> noOrderigns = <MigrationViewOrderOptions>[];
        options = MigrationViewOptions(null, noOrderigns, 1, 10, false);
        viewMock = MigrationView<Truck>(<Truck>[], 1, DateTime.now(), 3, 0, 20);

        List<Plate> plates = <Plate>[Plate(1, "testplate 1", "BC", "MX", DateTime.now(), 1, null), Plate(2, "testplate 2", "ACV", "USA", DateTime.now(), 2, null)];
        SCT sct = SCT(1, "type fsdf", "number 2344235", "configuration 32131", <Truck>[]);
        Maintenance maintenance = Maintenance(1, DateTime.now(), DateTime.now(), <Truck>[]);
        Situation situation = Situation(1, "name test 111", "description test 323", <Truck>[]);
        Insurance insurance = Insurance(1, "policy number 232", DateTime.now(), "MEX", <Truck>[]);
        Manufacturer manufacturer = Manufacturer(1, "S12", "SCANIA", DateTime.now(), <Truck>[]);
        Truck model = Truck(1, "VIN23243242342334", 0, "MotorNumber21323", null, null, null, null, manufacturer, sct, maintenance, situation, insurance, plates);
        for (CSMSetValidationResult validation in model.evaluate()) {
          print(validation.reason);
        }

        models.add(model);
        createMock = MigrationTransactionResult<Truck>(<Truck>[], <MigrationTransactionFailure<Truck>>[], 0, 0, 0, false);

        Client mockClient = MockClient(
          (Request request) async {
            JObject jObject = switch (request.url.pathSegments.last) {
              'view' => SuccessFrame<MigrationView<Truck>>('qTracer', viewMock).encode(),
              'create' => SuccessFrame<MigrationTransactionResult<Truck>>('qTracer', createMock).encode(),
              _ => <String, dynamic>{},
            };

            String object = jsonEncode(jObject);
            return Response(object, 200);
          },
        );

        service = TWSAdministrationSource(
          true,
          client: mockClient,
        ).trucks;
      },
    );

    test(
      'View',
      () async {
        MainResolver<MigrationView<Truck>> fact = await service.view(options, '');

        bool passed = false;
        fact.resolve(
          decoder: MigrationViewDecode<Truck>(TruckDecoder()),
          onConnectionFailure: () {},
          onFailure: (FailureFrame failure, int status) {
            assert(false, 'server returned a success $status');
          },
          onException: (Object exception, StackTrace trace) {
            assert(false, 'server returned a success');
          },
          onSuccess: (SuccessFrame<MigrationView<Truck>> success) {
            passed = true;

            MigrationView<Truck> fact = success.estela;
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
      "Create",
      () async {
        MainResolver<MigrationTransactionResult<Truck>> fact = await service.create(models, "");
        bool passed = false;
        fact.resolve(
          decoder: MigrationTransactionResultDecoder<Truck>(TruckDecoder()),
          onConnectionFailure: () {
            throw 'ConnectionFailure';
          },
          onFailure: (FailureFrame failure, int status) {
            assert(false, 'server returned a success $status');
          },
          onException: (Object exception, StackTrace trace) {
            assert(false, 'server returned a success');
          },
          onSuccess: (SuccessFrame<MigrationTransactionResult<Truck>> success) {
            passed = true;
          },
        );

        expect(passed, true, reason: 'expected the service returned a success');
      },
    );
  }, timeout: Timeout.factor(5));
}
