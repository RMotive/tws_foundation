import 'package:csm_client/csm_client.dart';
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
  Effect<SetViewOut<Section>> view(SetViewOptions<Section> options, String auth) async {
    CSMActEffect actEffect = await twsPost('view', options, auth: auth);
    return MainResolver<SetViewOut<Section>>(actEffect);
  }
}
      