import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class SectionsService extends SectionsServiceBase {
  SectionsService(
    CSMUri host, {
    Client? client,
  }) : super(
          host,
          'Sections',
          client: client,
        );
        
  @override
  Effect<SetViewOut<Section>> view(SetViewOptions options, String auth) async {
    CSMActEffect actEffect = await post('view', options, auth: auth);
    return MainResolver<SetViewOut<Section>>(actEffect);
  }
}
      