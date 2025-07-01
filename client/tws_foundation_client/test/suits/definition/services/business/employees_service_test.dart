import 'package:csm_client/csm_client.dart';
import 'package:test/test.dart';
import 'package:tws_foundation_client/src/services/business/employees/employees_service_i.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../../../../utils/test_utils.dart';

void main() {
  final ViewOutput<Employee> viewOutputMock = ViewOutput<Employee>(employeeBuilder);

  late EmployeesServiceI serviceMock;

  setUp(
    () {
      viewOutputMock.page = 1;
      viewOutputMock.pages = 1;

      final MockClient mockClient = TestUtils.createMockClient(
        <String, EncodableI>{
          'view': viewOutputMock,
        },
      );

      serviceMock = EmployeesService(
        Uri('', ''),
        client: mockClient,
      );
    },
  );

  test(
    '(def) [view]: correctly gets a {ViewOutput} generated.',
    () async {
      final ViewInput<Employee> viewInput = ViewInput<Employee>.b(1, 10);

      final FoundationResponseResolver<ViewOutput<Employee>> resolver = await serviceMock.view(viewInput, '');

      final ViewOutput<Employee> viewOutput = resolver.resolveDirect(() => viewOutputBuilder(employeeBuilder));

      expect(viewOutputMock.page, viewOutput.page);
      expect(viewOutputMock.pages, viewOutput.pages);
      expect(viewOutputMock.entities, viewOutput.entities);
      expect(viewOutputMock.timestamp, viewOutput.timestamp);
    },
  );
}
