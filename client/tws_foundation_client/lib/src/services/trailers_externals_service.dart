import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TrailersExternalsService extends TrailersExternalsServiceBase {
  TrailersExternalsService(
    CSMUri host, {
    Client? client,
  }) : super(
          host,
          'TrailersExternals',
          client: client,
        );
        
  @override
  Effect<MigrationView<TrailerExternal>> view(MigrationViewOptions options, String auth) async {
    CSMActEffect actEffect = await post('view', options, auth: auth);
    return MainResolver<MigrationView<TrailerExternal>>(actEffect);
  }
}
      