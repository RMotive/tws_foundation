import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/services/business/misc/sections/sections_service_b.dart';
import 'package:tws_foundation_client/src/services/models/outputs/batch_operation_output.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

///
final class SectionsService extends SectionsServiceB {
  ///
  SectionsService(
    Uri host, {
    super.client,
  }) : super(
          host,
          'sections',
        );

  @override
  FoundationFutureResolver<ViewOutput<Section>> view(ViewInput<Section> input, String authToken) async {
    return FoundationResponseResolver<ViewOutput<Section>>(
      await postSecure<ViewInput<Section>>(
        'view',
        input,
        authToken: authToken,
      ),
    );
  }

  @override
  FoundationFutureResolver<BatchOperationOutput<Section>> create(List<Section> sections, String authToken) async {
    return FoundationResponseResolver<BatchOperationOutput<Section>>(
      await postListSecure<Section>(
        'create',
        sections,
        authToken: authToken,
      ),
    );
  }

  @override
  FoundationFutureResolver<UpdateOutput<Section>> update(UpdateInput<Section> input, String authToken) async {
    return FoundationResponseResolver<UpdateOutput<Section>>(
      await postSecure(
        'update',
        input,
        authToken: authToken,
      ),
    );
  }
}
