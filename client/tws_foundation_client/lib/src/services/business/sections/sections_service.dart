import 'package:csm_client/csm_client.dart';
import 'package:tws_foundation_client/src/core/typdefs.dart';
import 'package:tws_foundation_client/src/models/inputs/set_view_input/set_view_input.dart';
import 'package:tws_foundation_client/src/models/outputs/set_view_output.dart';
import 'package:tws_foundation_client/src/services/business/sections/sections.dart';
import 'package:tws_foundation_client/src/services/business/sections/sections_service_base.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

///
final class SectionsService extends SectionsServiceBase {
  ///
  SectionsService(
    Uri host, {
    Client? client,
  }) : super(
          host,
          'Sections',
          client: client,
        );

  ///
  @override
  Effect<SetViewOutput<Section>> view(SetViewInput<Section> input, String auth) async {
    ResponseController actEffect = await postSecure('view', input, authToken: auth);

    return FoundationResponseResolver<SetViewOutput<Section>>(actEffect);
  }
}
