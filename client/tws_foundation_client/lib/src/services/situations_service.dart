import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class SituationsService extends SituationsServiceBase {
  SituationsService(
    CSMUri host, {
    Client? client,
  }) : super(
          host,
          'Situations',
          client: client,
        );

  @override
  Effect<MigrationView<Situation>> view(MigrationViewOptions options, String auth) async {
    CSMActEffect actEffect = await post('view', options, auth: auth);
    return MainResolver<MigrationView<Situation>>(actEffect);
  }
}
