import 'package:csm_foundation_services/csm_foundation_services.dart';
import 'package:tws_foundation_client/tws_foundation_client.dart';

final class TrailersService extends TrailersServiceBase {
  TrailersService(
    CSMUri host, {
    Client? client,
  }) : super(
          host,
          'Trailers',
          client: client,
        );
        
  @override
  Effect<MigrationView<Trailer>> view(MigrationViewOptions options, String auth) async {
    CSMActEffect actEffect = await post('view', options, auth: auth);
    return MainResolver<MigrationView<Trailer>>(actEffect);
  }
}
      