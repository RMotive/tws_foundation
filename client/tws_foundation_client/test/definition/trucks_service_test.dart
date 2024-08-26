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
        // models = <Truck>[];
        List<MigrationViewOrderOptions> noOrderigns = <MigrationViewOrderOptions>[];
        options = MigrationViewOptions(null, noOrderigns, 1, 10, false);
        viewMock = MigrationView<Truck>(<Truck>[], 1, DateTime.now(), 3, 0, 20);
        // //SCT sct = SCT(0, 1,"type test", "number 2344235", "configuration 32131", null, <Truck>[]);
        // Maintenance maintenance = Maintenance(1, 1,DateTime.now(), DateTime.now(), null, <Truck>[]);
        // Insurance insurance = Insurance(1, 1, "policy number 232", DateTime.now(), "MEX", null, <Truck>[]);
        // Manufacturer manufacturer = Manufacturer(1, "S12", "SCANIA", DateTime.now(), <Truck>[]);
        // USDOT usdot = USDOT(1, 1, "MC test", "scac", null);
        // Address address = Address(1, "USA", "TX", "street", "altStreet", "city", "22200", null, <Carrier>[]);
        // Approach approach = Approach(1, 1, "email", "enterpriseNUM", "personalNUM", "alternative contact", null, <Carrier>[]);
        // Situation situation = Situation(1, 1,"name test 111", "description test 323", null, <Truck>[]);
        // Carrier carrier = Carrier(1, 1, 1, 1, "Carrier name", "carrier description", 1, 1, approach, address, usdot, null, null, <Truck>[]);
        // List<Plate> plates = <Plate>[ Plate(1, 1, "testplate 1", "BC", "MX", DateTime.now(), 0, null, null, null, null),  Plate(1, 1, "testplate 2", "ACV", "USA", DateTime.now(), 0, null, null, null, null)];
        // TruckCommon common = TruckCommon(1, 1, 1, "VIN23243242342334", "EconomicNumber21", 1, 1, null, plates);
        // Truck model = Truck(1, 1, 1, 1,"MotorNumber21323" , 0, 1, null, manufacturer, common, maintenance, insurance);
        // for(CSMSetValidationResult validation in model.evaluate()){
        //   print("${validation.property} : ${validation.reason}");
        // }

        // models.add(model);
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
        MainResolver<MigrationView<Truck>> fact =
            await service.view(options, '');

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
