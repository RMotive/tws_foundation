import 'dart:convert';

import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

void main() {
  late TrucksServiceBase service;
  late SetViewOut<Truck> viewMock;
  late SetViewOptions<Truck> options;
  late RecordUpdateOut<Truck> updateMock;  
  late Truck deleteMock;
  

  SetBatchOut<Truck> createMock;
  List<Truck> models = <Truck>[];
  
  group("Truck Service - Definition Service", () {
    setUp(
      () {
        // models = <Truck>[];
        List<SetViewOrderOptions> noOrderigns = <SetViewOrderOptions>[];
        options = SetViewOptions<Truck>(false, 10, 1, null, noOrderigns, <SetViewFilterNodeInterface<Truck>>[]);
        updateMock = RecordUpdateOut<Truck>(Truck.a(), Truck.a());
        viewMock = SetViewOut<Truck>(<Truck>[], 1, DateTime.now(), 3, 0, 20);
        deleteMock = Truck.a();


        // models.add(model);
        createMock = SetBatchOut<Truck>(<Truck>[], <SetOperationFailure<Truck>>[], 0, 0, 0, false);

        Client mockClient = MockClient(
          (Request request) async {
            JObject jObject = switch (request.url.pathSegments.last) {
              'view' => SuccessFrame<SetViewOut<Truck>>('qTracer', viewMock).encode(),
              'create' => SuccessFrame<SetBatchOut<Truck>>('qTracer', createMock).encode(),
              'update' => SuccessFrame<RecordUpdateOut<Truck>>('qTracer', updateMock).encode(),
              'delete' => SuccessFrame<Truck>('qTracer', deleteMock).encode(),

            _ => <String, dynamic>{},
          };
          
          String object = jsonEncode(jObject);
          return Response(object, 200);
          },
        );

        service = TWSFoundationSource(
          true,
          client: mockClient,
        ).trucks;
      },
    );

    test(
      'View',
      () async {
        MainResolver<SetViewOut<Truck>> fact =
            await service.view(options, '');

        bool passed = false;
        fact.resolve(
          decoder: (JObject json) => SetViewOut<Truck>.des(json, Truck.des),
          onConnectionFailure: () {},
          onFailure: (FailureFrame failure, int status) {
            assert(false, 'server returned a success $status');
          },
          onException: (Object exception, StackTrace trace) {
            assert(false, 'server returned a success');
          },
          onSuccess: (SuccessFrame<SetViewOut<Truck>> success) {
            passed = true;

            SetViewOut<Truck> fact = success.estela;
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
        MainResolver<SetBatchOut<Truck>> fact = await service.create(models, "");
        bool passed = false;
        fact.resolve(
          decoder: (JObject json) => SetBatchOut<Truck>.des(json, Truck.des),
          onConnectionFailure: () {
            throw 'ConnectionFailure';
          },
          onFailure: (FailureFrame failure, int status) {
            assert(false, 'server returned a success $status');
          },
          onException: (Object exception, StackTrace trace) {
            assert(false, 'server returned a success');
          },
          onSuccess: (SuccessFrame<SetBatchOut<Truck>> success) {
            passed = true;
          },
        );
        
        expect(passed, true, reason: 'expected the service returned a success');
      },
    );
  test(
    'Update',
    () async {
      MainResolver<RecordUpdateOut<Truck>> fact = await service.update(Truck.a(), '');
      bool pased = false;
      fact.resolve(
        decoder: (JObject json) => RecordUpdateOut<Truck>.des(json, Truck.des),
        onConnectionFailure: () {},
        onFailure: (FailureFrame failure, int status) {
          throw failure;
        },
        onSuccess: (SuccessFrame<RecordUpdateOut<Truck>> success) {
          pased = true;
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
      );
      expect(pased, true);
    },
  );
    test(
    'Delete',
    () async {
      MainResolver<Truck> fact = await service.delete(Truck.a(), '');
      bool pased = false;
      fact.resolve(
        decoder: (JObject json) => Truck.des(json),
        onConnectionFailure: () {
          throw 'ConnectionFailure';
        },
        onException: (Object exception, StackTrace trace) {
          throw exception;
        },
        onFailure: (FailureFrame failure, int status) {
          throw failure.estela.system;
        },
        onSuccess: (SuccessFrame<Truck> success) {
          pased = true;
          expect(pased, true);
        },
      );
    },
  );

  }, timeout: Timeout.factor(5));
}
