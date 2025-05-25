import 'package:test/test.dart';
import 'package:tws_foundation_client/src/services/models/outputs/batch_operation_output.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

import '../../../../utils/entity_building_utils.dart';
import '../../../../utils/integration_utils.dart';

void main() {
  late SolutionsServiceI service;
  late String testAuthToken;

  setUp(
    () async {
      service = FoundationServer(false).solutionsService;

      testAuthToken = await IntegrationUtils.getAuthToken();
    },
  );

  test(
    '[create] correctly creates a collection of {Solution} entites',
    () async {
      final List<Solution> solutions = <Solution>[
        EntityBuildingUtils.solution(),
        EntityBuildingUtils.solution(),
      ];

      final FoundationResponseResolver<BatchOperationOutput<Solution>> createResolver = await service.create(solutions, testAuthToken);

      final BatchOperationOutput<Solution> createOutput = createResolver.resolveDirect(
        () => BatchOperationOutput<Solution>(
          () => Solution(),
        ),
      );

      expect(createOutput.failed, false);
      expect(createOutput.failuresCount, 0);
      for (Solution successSolution in createOutput.successes) {
        expect(successSolution.id > BigInt.from(0), true);
      }
    },
  );

  test(
    '[update] correctly updates a {Solution} entity',
    () async {
      final Solution solutionMock = EntityBuildingUtils.solution();

      final FoundationResponseResolver<BatchOperationOutput<Solution>> createResolver = await service.create(<Solution>[solutionMock], testAuthToken);

      final BatchOperationOutput<Solution> createOutput = createResolver.resolveDirect(
        () => BatchOperationOutput<Solution>(
          () => Solution(),
        ),
      );

      expect(createOutput.successesCount, 1);

      final String udpatedName = 'test_update_name';
      final Solution solution = createOutput.successes[0];
      solution.name = udpatedName;

      final FoundationResponseResolver<UpdateOutput<Solution>> updateResolver = await service.update(UpdateInput<Solution>(solution), testAuthToken);

      final UpdateOutput<Solution> updateOutput = updateResolver.resolveDirect(
        () => UpdateOutput<Solution>(
          () => Solution(),
        ),
      );

      expect(updateOutput.original?.id, solution.id);
      expect(updateOutput.original?.name, solutionMock.name);
      expect(updateOutput.updated.name, udpatedName);
    },
  );
}
