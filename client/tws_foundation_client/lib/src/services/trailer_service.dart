import 'package:csm_client/csm_client.dart';
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
  Effect<SetViewOut<Trailer>> view(SetViewOptions<Trailer> options, String auth) async {
    CSMActEffect actEffect = await post('view', options, auth: auth);
    return MainResolver<SetViewOut<Trailer>>(actEffect);
  }
}
      